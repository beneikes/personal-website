---
title: 'Tuning a PI Current Controller: A Worked Example'
description: 'Deriving PI gains analytically from a motor''s electrical time constant, then implementing and simulating the discrete controller.'
pubDate: 2026-03-10
---

> *This is placeholder content for demonstration purposes — to be replaced with a real article.*

The current loop is the innermost — and usually the fastest — control loop in
a motor drive. Get it right and everything built on top of it (speed loops,
position loops, field-oriented control) becomes much easier to tune. Here's a
worked example of deriving PI gains analytically, then checking them in code.

## The plant model

Electrically, a motor phase looks like a series resistor and inductor driving
against a back-EMF disturbance $e$:

$$
L \frac{di}{dt} + Ri = u - e
$$

Treating the back-EMF as a slow disturbance and taking the Laplace transform
gives a first-order plant from applied voltage $u$ to phase current $i$:

$$
G(s) = \frac{I(s)}{U(s)} = \frac{1}{Ls + R} = \frac{1/R}{\tau s + 1},
\qquad \tau = \frac{L}{R}
$$

## Pole-zero cancellation with a PI controller

A PI controller has transfer function

$$
C(s) = K_p + \frac{K_i}{s} = K_p \, \frac{s + K_i / K_p}{s}
$$

If we place the controller's zero exactly on top of the plant's pole — i.e.
choose $K_i / K_p = R / L$ — the $(\tau s + 1)$ terms cancel and the open-loop
transfer function collapses to a pure integrator:

$$
C(s)\,G(s) = \frac{K_p}{L} \cdot \frac{1}{s}
$$

That integrator crosses unity gain at $\omega_c = K_p / L$. So instead of
hand-tuning two coupled gains, we just pick a desired closed-loop bandwidth
$\omega_c$ — typically somewhere around a tenth of the PWM switching
frequency — and the gains fall out directly:

$$
K_p = \omega_c L, \qquad K_i = \omega_c R
$$

## Discretizing the controller

Running at a fixed sample time $T_s$, the velocity-form discrete PI update is

$$
u[k] = u[k-1] + K_p \big(e[k] - e[k-1]\big) + K_i T_s\, e[k]
$$

which avoids recomputing the full integral each tick and makes anti-windup
clamping straightforward — clamp the accumulator, not the derivative term.

## Implementation in C

```c
typedef struct {
    float kp;
    float ki;
    float ts;
    float integrator;
    float out_min;
    float out_max;
} pi_controller_t;

float pi_update(pi_controller_t *pi, float setpoint, float measured)
{
    float error = setpoint - measured;

    pi->integrator += pi->ki * pi->ts * error;
    if (pi->integrator > pi->out_max) pi->integrator = pi->out_max;
    if (pi->integrator < pi->out_min) pi->integrator = pi->out_min;

    float output = pi->kp * error + pi->integrator;
    if (output > pi->out_max) output = pi->out_max;
    if (output < pi->out_min) output = pi->out_min;

    return output;
}
```

## Checking the result in simulation

Before flashing anything to hardware, it's worth simulating the closed loop
against the plant model to confirm the step response looks the way the
analysis predicts — critically damped, settling within a few electrical time
constants, no overshoot:

```python
import numpy as np

def simulate(kp, ki, ts, r, l, steps=2000, ref=1.0):
    i = 0.0
    integrator = 0.0
    trace = []
    for _ in range(steps):
        error = ref - i
        integrator += ki * ts * error
        u = kp * error + integrator
        i += (u - r * i) / l * ts
        trace.append(i)
    return np.array(trace)

# omega_c chosen at ~1/10th of the PWM frequency
omega_c = 2 * np.pi * 2_000.0
r, l = 0.5, 0.001
kp, ki = omega_c * l, omega_c * r
trace = simulate(kp, ki, ts=1 / 20_000, r=r, l=l)
```

If the simulated response matches the analytical prediction — roughly
$1/\omega_c$ seconds to settle — the gains are usually good enough to try on
the bench, with only minor tweaks needed once real ADC noise and PWM
quantization enter the picture.

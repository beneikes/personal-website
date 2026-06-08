---
title: 'An Introduction to Field-Oriented Control (FOC)'
description: 'How Clarke and Park transforms turn a three-phase AC motor into something that behaves like a simple DC motor for control purposes.'
pubDate: 2026-02-02
---

> *This is placeholder content for demonstration purposes — to be replaced with a real article.*

Permanent-magnet synchronous motors (PMSMs) and brushless DC motors (BLDCs)
are everywhere — drones, e-bikes, industrial servos, EV traction drives — but
they're awkward to control directly. Their three sinusoidal phase currents
constantly change relative to the rotor position, so a controller that just
watches raw phase currents is chasing a moving target. **Field-oriented
control (FOC)** solves this with a change of perspective: rotate the
reference frame so it spins along with the rotor, and the problem collapses
into something far simpler.

## Clarke and Park transforms

The **Clarke transform** converts the three-phase currents (which sum to
zero, so really only carry two independent degrees of freedom) into a
two-axis stationary reference frame, conventionally called α-β.

The **Park transform** then rotates that stationary frame into one that spins
synchronously with the rotor's magnetic field, producing two new components:
**d** (direct axis, aligned with the rotor flux) and **q** (quadrature axis,
perpendicular to it, responsible for torque production).

In this rotating d-q frame, steady-state currents become *constant* — the
same trick that makes a spinning AC machine controllable with the same kind of
PI loops you'd use on a DC motor.

## The current control loop

With currents expressed in the d-q frame, FOC typically runs:

- A **q-axis current loop** that regulates torque-producing current
- A **d-axis current loop** that regulates flux-producing current (often held
  near zero for surface-mount PMSMs, to maximize torque per amp)
- An outer **speed** (and sometimes **position**) loop that sets the
  q-axis current setpoint

The controller measures phase currents and rotor angle (from an encoder, a
resolver, or estimated sensorlessly), runs the Clarke/Park transforms forward,
closes the d/q current loops, then runs the inverse transforms to produce the
PWM duty cycles that the inverter applies to the motor.

A future article will look at sensorless angle estimation — and the
trade-offs that come with removing the position sensor entirely.

---
title: 'Motor Control Basics: An Introduction'
description: 'A short overview of open-loop vs. closed-loop control and why PWM is everywhere in motor drives.'
pubDate: 2026-01-15
---

> *This is placeholder content for demonstration purposes — to be replaced with a real article.*

Electric motors are everywhere, but the way we command them to do useful work
varies enormously depending on the application. At the simplest level, motor
control comes down to deciding how much voltage (and at what frequency and
phase) to apply, and then deciding *when* to adjust that based on what the
motor is actually doing.

## Open-loop vs. closed-loop control

In an **open-loop** system, the controller sends a command — say, a duty
cycle — without ever checking what the motor actually does in response. This
is simple and cheap, but it falls apart under varying load: a fan motor and a
stalled motor look identical to a controller that never measures anything.

A **closed-loop** system feeds a measurement (speed, current, position) back
into the controller, which continuously adjusts its output to drive the error
between the desired and actual state toward zero. This is the foundation of
nearly every serious motor control application, from robotics to electric
vehicles.

## Why PWM?

Pulse-width modulation (PWM) lets a controller emulate an arbitrary average
voltage using only an on/off switch, by rapidly switching between fully-on and
fully-off and varying the proportion of time spent in each state. Combined
with the inductance of a motor winding (which smooths out the switching into a
near-continuous current), PWM is what makes efficient variable-speed motor
drives possible without burning power in linear regulators.

Future articles will dig into specific control strategies — starting with
field-oriented control for permanent-magnet motors.

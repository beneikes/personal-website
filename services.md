## Services

# Control design

Sometimes off-the-shelf drives and libraries won’t meet your performance or stability requirements. 
A model-based approach gets the most out of your system: through modeling, analysis, and simulation, control algorithms are designed and parameterized systematically, not by trial and error.

Using the tools and libraries I’ve developed in MATLAB/Simulink, Python, and C, I cover:

- **Field-oriented control (FOC)** for BLDC, PMSM, IPMSM, SynRM, and stepper motors: SVPWM, MTPA, field weakening, and active harmonic suppression algorithms
- **Sensorless control**: silent high-frequency injection (HFI), flux and back-EMF observers, start-up routines, and hybrid schemes across the full speed range
- **Motion control**: cascaded control (P-PI, PID), optimal state-space control and estimation (LQR, Kalman filter), and specialized algorithms for robots (CTC) and elastic systems (LQG, ADRC)
- **Embedded code** for STM32, NXP, Infineon, TI C2000, and other microcontrollers: hand-written MISRA C–compliant code, or code generation with Embedded Coder
- **Peripheral configuration**: PWM, ADC, timer, and interrupt setup for precisely synchronized sampling with any current-sensing topology, including single-shunt
- **Validation**: model-, software-, processor-, and hardware-in-the-loop testing (MIL, SIL, PIL, HIL)

# System identification

Your real system behaves differently from the simulation, or the datasheet values don’t match your measurements?
Accurate models and parameters are not only essential for model-based control design and system analysis, but also helpful for finding replacement parts or benchmarking competitors.

Using specialized test benches, drives, and identification algorithms, I identify:

- **Motor parameters and characteristics** for BLDC, PMSM, IPMSM, SynRM, and stepper motors: linear parameters (L_d, L_q, R_s, Psi_m), flux maps including cross-saturation, back-EMF harmonics, torque–speed curves, efficiency maps, and torque ripple
- **Mechanical parameters** of drive trains, including elastic transmissions such as harmonic drives: inertia, stiffness, damping, backlash, and friction (Coulomb, viscous, Stribeck)
- **Load characteristics** of pumps, hydraulic systems, or propellers
- **Drive and sensor non-idealities**: control delays, inverter dead time, measurement noise, and encoder angle errors

# Custom hardware

Off-the-shelf drives can’t deliver what your application needs, or the test equipment you need doesn’t exist?
Custom hardware designed for your drive system avoids the compromises of generic solutions.

Building on drive electronics and test benches I’ve designed for client projects and my own work, I develop:

- **Drive electronics**: functional prototypes of inverter and controller boards, from compact robot joint drives to high-power electric turbocharger drives
- **Hardware-in-the-loop (HIL) test benches**: real-time mechanical load emulation for testing drives and control algorithms without risking the real mechanism
- **Identification test benches and drives**: parameter identification and validation of motors, gearboxes, and complete drive trains
- **End-of-line (EOL) test systems**: automated production testing, such as encoder calibration, gearbox performance, and motor magnetization checks

# Troubleshooting

Your system misses its design goals, vibrates, or fails to start in sensorless mode, and the cause isn’t obvious? Or some units run fine while others fail?
Finding the root cause takes systematic measurements, accurate models, and experience with what typically goes wrong.

I’m happy to help on-site, bringing my own analysis tools and test systems. I offer:

- **Root-cause analysis**: measurements and analysis of instability, vibration, audible noise, and start-up issues
- **Code and configuration reviews**: control code and peripheral configuration, checked for timing, sampling, and implementation errors
- **Design reviews**: control concepts and schematics reviewed during development, to catch issues before they reach production
- **Tuning and optimization**: improving existing control systems without starting from scratch
- **Commissioning**: parameter setup and functional testing of new motors, drives, and actuators

# Training

You want to develop your drive system in-house, but the know-how or toolchain is still missing? 
The goal is a solid foundation your engineers can rely on long after the project ends.

I offer training on-site or remotely in the form of:

- **Workshops**: model-based control design and system analysis, FOC and sensorless control, and embedded code implementation
- **Coaching**: hands-on support for engineers on their projects and challenges
- **Toolchain setup**: a model-based design workflow in MATLAB/Simulink or Python covering control design, analysis, simulation, code implementation, and validation

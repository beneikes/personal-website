---
title: 'Current Control'
description: 'In field-oriented control (FOC), the inner current control loop serves as the foundation for all higher-level control loops.'
pubDate: 2026-06-18
---


# Entwurf der Stromregelung

Die (feldorientierte) Stromregelung ist das Fundament einer performanten Positions-, Geschwindigkeits- oder Momentenregelung. Ein guter Reglerentwurf stellt nicht nur die allgemeinen [Anforderungen an Regelsysteme](#ref) sicher, sondern garantiert allen übergeordneten Algorithmen ein deterministisches Übertragungsverhalten, unabhängig vom Arbeitspunkt.  

Die in der Praxis von einigen Fallstricken geprägt ist. Durch die Entkopplung der Spannungsgleichungen (*Referenz folgt*)  

## Entkopplung der Spannungsgleichungen

Den verkoppelten Spannungsgleichungen im dq-System 

$$
\begin{aligned} 
u_d &= R_s i_d + L_d \frac{di_d}{dt} - \Omega_{el} L_q i_q \\
u_q &= R_s i_q + L_q \frac{di_q}{dt} + \Omega_{el} L_d i_d + \Omega_{el} {\Psi}_m 
\end{aligned}
$$

können mit den Aufschaltungen

$$
\begin{aligned} 
u_{dcpl,d} &= \Omega_{el} L_q i_q \\
u_{dcpl,q} &= -(\Omega_{el} L_d i_d + \Omega_{el} \Psi_m) 
\end{aligned}
$$

entkoppelt werden. Hierdurch werden ebenfalls die geschwindigkeitsabhängingen Terme eliminiert. Für eine wirksame Entkopplung wird neben den Motorparametern $L_d$, $L_q$ und $\Psi_m$ ebenfalls die elektrische Geschwindigkeit $\Omega_{el}$ benötigt. Diese wird in der Regel über einen geeigneten Beobachter geschätzt. 

**_HINWEIS:_**  Ein fehlerhafter Geschwindigkeitsbeobachter kann über die Entkopplungsterme die Stromregeleinrichtung destabilisieren.

Die entkoppelten Spannungsterme weisen für d- und q-Achse die gleiche Struktur auf, die im Folgenden mit

$$ u = R i + L \frac{di}{dt} $$  

allgemein gehalten wird. 

## Wahl der Reglerstruktur

Mithilfe der Laplace-Transformation folgt aus dem entkoppelten, allgemeinen Modell

$$ G_p(s) = \frac{1}{Ls + R} = \frac{\frac{1}{R}}{\frac{L}{R} s + 1}$$

für die Übertragungsfunktion der Regelstrecke. Um stationärere Genauigkeit bei sprungförmiger Führungs- und Störanregung sicherzustellen, müssen die Grenzwertbildungen 

$$ \lim_{t \to \infty} y(t) = \lim_{s \to 0} s \cdot G_w(s) \cdot \frac{1}{s} = 1 $$

und

$$ \lim_{t \to \infty} y(t) = \lim_{s \to 0} s \cdot G_z(s) \cdot \frac{1}{s} = 0 $$

ergeben. Dies wird die Wahl einer geeigneten Regelstruktur sichergestellt. 

### P-Regler

Mit der Wahl eines einfachen P-Reglers $G_r(s) = k_p$ führt die Grenzwertbildung zu

$$ \lim_{t \to \infty} y(t) = \lim_{s \to 0} s \cdot \frac{k_p}{L s + R + k_p} \cdot \frac{1}{s} = \frac{k_p}{R + k_p} \neq 1 $$

Somit wird Anforderung an stationäre Genuaigkeit durch die Wahl eines P-Reglers nicht erfüllt.

### PI-Regler

Wird der P-Regler um einen integralen Teil zu einem PI-Regler $G_r(s) = k_p + \frac{k_i}{s}$ erweitert, so erfüllt die Grenzwertbildung

$$ \lim_{t \to \infty} y(t) = \lim_{s \to 0} s \cdot \frac{k_p s + k_i}{L s^2 + k_p s + R s + k_i} \cdot \frac{1}{s} = \frac{k_i}{k_i} = 1 $$

die Anforderung an stationäre Genauigkeit bei sprungförmiger Führungsanregung. Auch bei sprungförmiger Störanregung weist der Regelkreis mit

$$ \lim_{t \to \infty} y(t) = \lim_{s \to 0} s \cdot \frac{s(R + L s)}{L s^2 + k_p s + Rs + k_i} \cdot \frac{1}{s} = -\frac{0}{k_i} = 0 $$

stationäre Genauigkeit auf. Somit kommt zur Regelung ein PI-Regler zum Einsatz. 

## Ermittlung der Reglerparameter

Da die Regelstrecke ein einfaches PT1-Verhalten aufweist, kann mithilfe des PI-Reglers die Führungsübertragungsfunktion 

$$  G_w(s) = \frac{1}{T_w s + 1} $$

mit der Wunschzeitkonstaten $T_w$ eingestellt werden. Nach Gleichsetzen der Übertragungsfunktionen

$$ G_w(s) = \frac{k_p s + k_i}{L s^2 + k_p s + R s + k_i} \overset{!}{=}  \frac{1}{T_w s + 1}$$

folgt durch kreuzweise Multiplikation und Ausklammern der s-Potenzen die Gleichung

$$ k_p T_w s^2 + (k_p + k_i T_w)s + k_i = L s^2 + (R + k_p)s + k_i \;. $$

Mittels Koeffizientenvergleich können die Reglerverstärkungen

$$
\begin{aligned} 
k_p &= \frac{L}{T_w} \\
k_i &= \frac{R}{T_w} 
\end{aligned}
$$

ermittelt werden. Da die Nullstelle des Reglers mit diesen Verstärkungen die Polstelle der Strecke kompensiert, wird diese Art von Regler auch **Kompensationsregler** gennant. 


!!! note

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
    massa, nec semper lorem quam in massa.






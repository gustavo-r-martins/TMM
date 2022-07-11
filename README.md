# TMM
[T,R] = nmirror(n,d,k)
where n is the refractive index, d is the layer distance, k is the wave number. T and R are the transmission and reflection coefficients.
The distance vector must have an extra component, d(end) = 0.

For M dielectric mirrors, with M = 4, we have:
       |       |       |       |
   n0  |   n1  |   n2  |   n3  |   n4
       |   d1  |   d2  |   d3  |  d4=0
       |       |       |       |

|T|^2 + |R|^2 = +1. Using a normalized transfer matrix.

# Taller raster

## Propósito

Comprender algunos aspectos fundamentales del paradigma de rasterización.

## Tareas

Emplee coordenadas baricéntricas para:

1. Rasterizar un triángulo; y,
2. Sombrear su superficie a partir de los colores de sus vértices.

Referencias:

* [The barycentric conspiracy](https://fgiesen.wordpress.com/2013/02/06/the-barycentric-conspirac/)
* [Rasterization stage](https://www.scratchapixel.com/lessons/3d-basic-rendering/rasterization-practical-implementation/rasterization-stage)

Opcionales:

1. Implementar un [algoritmo de anti-aliasing](https://www.scratchapixel.com/lessons/3d-basic-rendering/rasterization-practical-implementation/rasterization-practical-implementation) para sus aristas; y,
2. Sombrear su superficie mediante su [mapa de profundidad](https://en.wikipedia.org/wiki/Depth_map).

Implemente la función ```triangleRaster()``` del sketch adjunto para tal efecto, requiere la librería [frames](https://github.com/VisualComputing/frames/releases).

## Integrantes

Dos, o máximo tres si van a realizar al menos un opcional.

Complete la tabla:

| Integrante | github nick |
|------------|-------------|
|Oscar Fabián Ñáñez Núñez  |ofnanezn |
|Juan Camilo Rubio Ávila   |jcrubioa |

## Discusión

Describa los resultados obtenidos. En el caso de anti-aliasing describir las técnicas exploradas, citando las referencias:

### Rasterización:
Para la rasterización se fue recorriendo celda por celda, verificando que el centro de esta se encontrara dentro del triángulo. Para esta verificación, se calculó el *edge function* con el fin de verificar si el punto $P$ (en este caso, el centro de la celda) se encontraba a la derecha o izquierda (dependiendo de la orientación) de la arista $v_{ij}$, la cual hace referencia a la línea que va desde el vértice $v_i$ al vértice $v_j$ del triángulo; haciendo este proceso con cada una de las aristas del triángulo. Para esto, se verifica que el *edge function* sea mayor que 0 para cada arista como se muestra a continuación:

$$E_{ij}(P)=(P.x−v_i.x)∗(v_j.y−v_i.y)−(P.y−v_i.y)∗(v_j.x−v_i.x)$$

$$E_{ij}(P) > 0 \quad \forall{v_{ij} \in T}$$

donde $T$ es el conjunto de aristas en el triángulo.

En caso de que se cumpla que la celda se encuentra dentro del triángulo, esta se pinta de algún color en particular.

### Coordenadas Baricéntricas:
Para las coordenadas baricéntricas, lo que se hizo fue en primer lugar fue asignar un color a cada uno de los vértices (rojo, verde y azul); para luego pintar la parte interior del triángulo en el punto $P$ de acuerdo a la siguiente expresión:

$$C_P= \lambda_0 C_{v_0} + \lambda_1 C_{v_1} + \lambda_2 C_{v_2}$$

donde cada $\lambda_i$ representado un peso ponderado que se le da al color en $v_i$, y $C_{v_i}$ representa al color de dicho vértice.

Para el cálculo de cada $\lambda_i$ se utilizó la *edge function* de la arista opuesta al vértice $v_i$ con respecto al punto P y también el área del triángulo, tal y como se muestra en la siguiente ecuación:

$$\lambda_i = \frac{E_{jk}(P)}{2*Area_{tri}(v_i, v_j, v_k)}$$

donde el área del triángulo se puede calcular de la siguiente manera:

$$Area_{tri}(v_i, v_j, v_k) = E_{ij}(k) = E_{jk}(i) = E_{ki}(j)$$

Por lo cual, se puede calcular una sola vez con el fin de ahorrarse algunos cálculos.

Finalmente, la celda se pinta con respecto al ponderado de cada uno de estos colores, dando así una sensación de combinación de los colores de cada vértice dentro del triángulo.

### Antialiasing:
La técnica utilizada para el antialiasing consiste en subdividir la celda que se está evaluando, en 4,8, 16... subceldas dependiendo del nivel de suavidad que se requiera, para después calcular el procentaje de subceldas que están dentro del triángulo. De acuerdo a este porcentaje se computa el nuevo color, a partir de un promedio ponderado entre el color del fondo y el color original de la celda.

Los resultados obtenidos reducen considerablemente los "jaggies" al subdividir las celdas en 16 subceldas para calcular el promedio de celdas dentro del triángulo. Subdivisiones más precisas resultan muy pesadas para una máquina de escritorio corriente, y el programa no es capaz de responder.

La técnica utilizada es conocida como prefiltering[1]. Es descrita también en[2]

Para utlizarlo, presionar la tecla "a" al correr el Sketch. Presionarla cambiará el nivel de antialiasing entre 1, 2, 4 y 1 de nuevo. 2 significa 4 subdivisiones por cada celda, mientras que 4 siginifica 16 subdivisiones.

## Referencias
[[1] Antialiasing strategies](https://web.cs.wpi.edu/~matt/courses/cs563/talks/antialiasing/methods.html)
[[2] Rasterization: a Practical Implementation](https://www.scratchapixel.com/lessons/3d-basic-rendering/rasterization-practical-implementation/rasterization-practical-implementation)

## Entrega

* Modo de entrega: [Fork](https://help.github.com/articles/fork-a-repo/) la plantilla en las cuentas de los integrantes.
* Plazo: 30/9/18 a las 24h.

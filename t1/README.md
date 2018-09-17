# Taller ilusiones visuales

## Propósito

Comprender algunos aspectos fundamentales de la [inferencia inconsciente](https://github.com/VisualComputing/Cognitive) de la percepción visual humana.

## Tareas

Implementar al menos 6 ilusiones de tres tipos distintos (paradójicas, geométricas, ambiguas, etc.), al menos dos con movimiento y dos con interactividad.

## Integrantes
(máximo dos)

Complete la tabla:

| Integrante | github nick |
|------------|-------------|
|Oscar Ñañez |ofnanezn	   |
|Juan Rubio  |jcrubioa     |

## Discusión

1. Complete la la tabla

| Ilusión | Categoria | Referencia | Tipo de interactividad (si aplica) | URL código base (si aplica) |
|---------|-----------|------------|------------------------------------|-----------------------------|
|Ilusion1         |Psicológica           |http://www.animations.physics.unsw.edu.au/jw/light/complementary-colours.htm            |Click para ocultar ilusión                                    |                             |
|Ilusion2         |Psicológica           |https://www.news.com.au/lifestyle/health/mind/the-reason-why-not-everyone-can-see-an-optical-illusion/news-story/e8529b1968c5c3ca2df851c46022b54d            |Click para ocultar ilusión                                    |                             |
|Ilusion3         |Cognitiva           |http://ilusionario-blog.blogspot.com/2014/02/la-escalera-imposible.html            |Agarrar y soltar para mover cámara. Doble click para volver a posición de ilusión inicial                                    |                             |
|Ilusion4         |Cognitiva           | https://www.michaelbach.de/ot/sze-shepardTerrors/index.html |Agarrar y soltar una de las imágenes del personaje            |                                    | 
|Ilusion5         |Psicológica           | https://www.michaelbach.de/ot/mot-ske/index.html           |                                    |                             |
|Ilusion6         |Paradójica           | https://www.michaelbach.de/ot/cog-imposs1/index.html |Click para ocultar una de las partes de la imagen            |                                |

2. Describa brevememente las referencias estudiadas y los posibles temas en los que le gustaría profundizar:

* **Ilusión 1:** Esta ilusión se basa en jugar con colores complementarios: El del magenta, que es el verde, y el del rojo(un poco naranja), que es el cian. Así, los pequeños arcos de circunferencia que forman un torbellino en la imagen son del mismo color: verde. Hay que fijarse en que los segmentos de las circunferencias de color naranja cubiertos por el torbellino verde se tornan cian, mientras que los segmentos magenta cubiertos por el torbellino quedan verdes.
* **Ilusión 2:** La ilusión 2 crea ruido en la imagen, confundiendo la vista del observador, y haciendo que se fije más en el patrón del zig-zag(más marcado) que en la imagen original que se esta ocultando(más sutil). Si se ve desde varios ángulos, o. mejor aún, desde lejos, la vista empieza a dejar de lado el ruido en la imagen y puede concentrarse más en la imagen oculta.
* **Ilusión 3:** La escalera de Penrose forma parte de una publicación de 1958 por Lionel y Roger Penrose, junto con otros "objetos imposibles". Esta ilusión es particularmente interesante, pues no tiene sentido en el mundo físico, y sin embargo no parece haber nada fuera de lugar en su representación 2D. En este script se crea un objeto 3D que, visto desde un ángulo preciso nos muestra la escalera de Penrose. Al girarlo, podremos descubrir su verdadera naturaleza. Me gustaría profundizar en el tema de las ilusiones cognitivas, pues pienso que son las más complejas de descifrar, en tanto no se basan en un "truco" sencillo aplicado de diferentes maneras, sino que requiere imaginación y destreza averiguar aquél objeto real que, visto desde el punto adecuado, nos muestra uno imposible.
* **Ilusión 4:** Esta ilusión consiste en engañar al espectador por medio de perspectivas. En este caso, tenemos dos imágenes del personaje Crash Bandicoot sobre el túnel de un tren. A primera vista, las dos imágenes de Crash son del mismo tamaño, si ponemos una al lado de la otra, sin embargo, a medida que vamos alejando la imagen arrastrable a la parte inferior, que es la parte del ferrocarril que se acerca hacia la pantalla perspectivamente, esta imagen de Crash, va a dar la impresión de parecer más pequeña. 
Esto es conocido como la ilusión Ponzo, la cual sugiere que Sugiere la mente humana, más específicamente nuestro sistema visual, estima la medida de un objeto basándose en su entorno. Es decir, ya que esta imagen es traida hacia la parte del fondo que consideramos más cercana, de igual manera, la imagen nos dará una impresión de cercanía. 
* **Ilusión 5:** Esta ilusión en particuar, es interesante, ya que en esta podemos ver como vamos supuestamente navegando en un tunel de longitud infinita, sin embargo, la secuencia solo representa una serie de circulos sobrepuestos uno sobre de otro siguiendo una secuencia con el patrón Perlin Noise para cada círculo generado, para darle así una sensación de continuidad en cada generación de cada círculo. Además, para agregar más sentido de profundidad, los círculos más distantes, por así decirlo, tienen un color más oscuro que el de los círculos más próximos.
Este tema está bastante relacionado con el de Kinetic Depth Effect, el cual busca crear construir representaciones tridimensionales a partir de movimiento de objetos 2D. Al final, obtenemos una figura que crea una sensación tridimensional, ya que este movimiento causa esa ilusión de profundidad en el espectador creada por el sistema visual. Esto es bastante interesante, ya que si no hubiera tal movimiento, se perdería esa sensación tridimensional.
* **Ilusión 6:**  Como se puede observar a simple vista, este se trata de un objeto sencillamente imposible de recrear, sin embargo que es creado sencillamente de manera gráfica. En este caso tenemos una imagen, la cual si la miramos de la mitad hacia arriba, da la impresión de tres torres ubicadas de manera contigua; y si la miramos de la mitad hacia abajo, da la impresión de una figura con la forma de una U. Sin embargo, al juntar estas dos imágenes, vemos patrones que no tienen sentido en el ámbito físico.
Sin embargo, algo bastante interesante sobre estas figuras, tal y como se describe en ["Modelling and Rendering of Impossible Figures"](http://www.cse.cuhk.edu.hk/leojia/papers/impossible_figure_tog10.pdf), es que se podría crear una representación de este tipo de imágenes, pero, solo desde un punto de vista, ya que, como se mencionó anteriormente, estas no tienen sentido en espacio físico.

### Temas de Interés
En mi caso, me interesó el tema de Kinetic Depth Illusion, ya que este podría en cierta manera optimizar el uso de efectos 3D mediante el reemplazo en algunos casos con estas ilusiones que se crean de manera bidimensional. 

## Entrega

* Modo de entrega: clonar este repo y subirlo a `https://github.com/username/cv/t1`.
* Plazo: 16/9/18 a las 24h.

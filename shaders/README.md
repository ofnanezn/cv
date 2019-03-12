# Taller de interacción

## Propósito

Estudiar las tres tareas universales de interacción en entornos virtuales.

## Tareas

Escoja una de las siguientes tres:

1. Emplee un [dispositivo de interfaz humana](https://en.wikipedia.org/wiki/Human_interface_device) no convencional para controlar una escena. Refiérase al ejemplo [SpaceNavigator](https://github.com/VisualComputing/frames/tree/master/examples/basics/SpaceNavigator). Se puede emplear la escena del [punto 2 del taller de transformaciones](https://github.com/VisualComputing/Transformations_ws)
2. Implemente una aplicación de _cámara en tercera persona_. Refiérase al ejemplo [FlockOfBoids](https://github.com/VisualComputing/frames/tree/master/examples/demos/FlockOfBoids).
3. Implemente una aplicación de _control de la aplicación_ (e.g., ["marking menus"](https://www.youtube.com/watch?v=twR_yxuHw24) o [vistas auxiliares](https://www.youtube.com/watch?v=Kr6-_NT_olo&feature=youtu.be&t=214)).

En cualquier caso se puede emplear la librería [frames](https://github.com/VisualComputing/frames) y/o cualquier otra.

## Integrantes

Máximo tres.

Complete la tabla:

| Integrante | github nick |
|------------|-------------|
|Oscar Fabián Ñáñez Núñez |ofnanezn |
|Juan Camilo Rubio Ávila |jcrubioa |
|Nicolás Leonardo Maldonado |nlmaldonadog |


## Informe

### Interacción
Para la sección de interacción se decidió conectar la escena con un dispositivo Kinect. Para la comunicación entre el kinect y Processing se utilizó la librería [OpenKinect-for-Processing](https://github.com/shiffman/OpenKinect-for-Processing). 

#### Kinect
El kinect envía un rayo infrarrojo al ambiente, y este captura una matriz con la profundidad de cada pixel. De esta matriz se toma el pixel más cercano, además del grupo de pixeles con una profundidad con una distancia *d* mayor que la del pixel más cercano, estos pixeles son pintados de color rojo.

Para interactuar con la escena, se está haciendo uso de las manos, y para ello se tienen en cuenta dos casos:

- **Interacción con dos manos:** Para la interacción con dos manos se realiza una técnica de clustering con el Algoritmo de k-means, con un número de clusters *k* = 2 y 5 iteraciones por frame. Este algoritmo es aplicado, tomando como dimensiones las posiciones x e y de cada punto. Al final, se toman los centroides, y estos mismos son pintados en la escena con dos puntos (verde y azul). Además, cada punto recibirá un label señalando el cluster al que pertenece. Teniendo en cuenta que el número del clúster podía variar por frame, para conservar la misma notación, se realiza un ordenamiento, donde el elemento menor sobre el eje x es considerado el primer cluster, y el siguiente el segundo cluster (con el fin de que los colores de los centroides permanezcan en su punto). Las dos manos son usadas para hacer las operaciones de rotación. 
- **Interacción con una mano:** Para la interacción con una mano se realiza igualmente el algoritmo k-means, sin embargo, se evalúa si la distancia euclidiana entre los dos centroides es menor a un valor *d*, entonces se toma como un solo centroide,el cual es simplemente el promedio de todos los puntos cercanos.

#### Escena
Para la escena, se están utilizando 10 cajas con ciertos rango de tamaño, y ubicadas aleatoriamente en el espacio.

#### Translacción
Para la translacción en x, y, z, se debe utilizar una mano, con el fin de que se detecte un solo centroide. Luego, solo se debe realizar movimientos en el eje en que se desea mover.

#### Rotación
Se tienen ciertos movimientos predefinidos para hacer las operaciones de rotación por eje.

Para rotar sobre el eje x, se debe acercar o alejar las manos para hacer una rotación en sentido positivo o negativo. Este movimiento es detectado primero recibiendo como entrada un número de clusters igual a 2, y luego, la profundidad es mappeada al ángulo de rotación para luego aplicarla al objeto seleccionado.

Para rotar sobre el eje y, se deben mover las manos en sentido opuesto, paralelas al eje y. Este movimiento es igualmente recibiendo como entrada un número de clusters igual a 2, y luego, la distancia en y entre los centroides es mappeada al ángulo que se va a aplicar en la rotación, ya sea positivo o negativo, dependiendo del centroide que se encuentra en primer lugar.

Para rotar sobre el eje z, se deben mover las manos en sentido opuesto, paralelas al eje z. Este movimiento es igualmente recibiendo como entrada un número de clusters igual a 2, y luego, la distancia en y entre los centroides es mappeada al ángulo que se va a aplicar en la rotación, ya sea positivo o negativo, dependiendo del centroide que se encuentra en primer lugar.

#### Escalamiento
Para escalar las figuras, se deben se deben mover las manos en sentido opuesto, paralelas al eje x. Esta transformación recibe como entrada un número de clusters igual a 2, y luego, dependiendo de si la distancia aumenta o disminuye, ese delta es usado para ampliar o reducir el objeto.

### Shaders
Con respecto a shaders, se realizó un fragment shader para la luz de la escena, la cual es de posición estática y es aplicada a cada uno de los objetos en la escena. 

## Entrega
Fecha límite Domingo 10/3/19 a las 24h.
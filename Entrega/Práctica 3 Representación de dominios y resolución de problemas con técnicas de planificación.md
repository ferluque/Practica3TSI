## Práctica 3: Representación de dominios y resolución de problemas con técnicas de planificación

### 1. Tabla de resultados

| Problema   | Longitud Plan          | Tiempo invertido  (s) |
| ---------- | ---------------------- | --------------------- |
| Problema 1 | 3                      | 0.00                  |
| Problema 2 | 11                     | 0.00                  |
| Problema 3 | 16                     | 0.02                  |
| Problema 4 | 28                     | 0.03                  |
| Problema 5 | 28                     | 0.02                  |
| Problema 6 | 24 (Óptimo)            | 0.03 + 1.08 + 0.54    |
| Problema 7 | 45                     | 24.31                 |
| Problema 8 | 46 (493 uds de tiempo) | 0.94                  |

​	Como podemos observar, los tiempos de ejecución de los diferentes problemas no tardan demasiado excepto para el problema 7. Pese a que he tratado de introducir bastantes precondiciones que en principio son innecesarias con el objetivo de restringir aún más el árbol de búsqueda, el tiempo se mantiene relativamente alto en comparación con los demás problemas.

​	He pensado que esto se puede deber al hecho de dejar que los predicados del tipo (necesita VCE Minerales) o las funciones del tipo (= (necesita VCE Minerales) 5), se declaren en el problema y se permita que estos se modifiquen en posibles problemas diferentes, en lugar de hacerlo como algo constante y universal y dejarlo en el fichero del dominio.

​	Sin embargo, se trata de un tiempo que no es para nada descabellado.

​	Por otro lado, aclarar que los tiempos que aparecen en la fila del problema 6 son la suma de los tiempos de las 3 búsquedas que se detallan en la primera pregunta del siguiente apartado.



### 2. Preguntas

#### Pregunta 1

**En las distintas llamadas a MetricFF necesarias para resolver el Ejercicio 6, ¿MetricFF tarda aproximadamente el mismo tiempo en todas ellas? ¿A qué cree que se debe este fenómeno? Razone su respuesta**

****

En mi caso en particular, únicamente he tenido que realizar 3 llamadas para resolverlo:

* La primera, sin poner condición que limite la longitud del plan, me daba un plan de longitud 28 y tardaba 0.03 segundos
* La segunda, limitando la longitud a un valor menor de 28 ya me da el valor óptimo de longitud 24 y tarda 1.08 segundos
* La última llamada sería intentando buscar un plan de longitud menor que 24 y fallando en ello, tarda un total de 0.54 segundos

<u>Por qué?</u>

#### Pregunta 2

**En base a los tiempos de ejecución obtenidos, ¿cree que el dominio de planificación planteado en esta práctica es de dificultad moderada/media/alta? ¿Cuáles son las limitaciones de la planificación automática en otros dominios?**

---

​	Si bien es cierto que en el problema 7 los tiempos se me han disparado bastante en comparación con los demás problemas, los tiempos de los demás ejercicios nos indican que este dominio no presenta mucha dificultad y que en problemas bastante complejos como podían ser el 6 o el 8, la búsqueda de una planificación correcta en incluso óptima se puede realizar en bastante poco tiempo de ejecución.

​	El principal problema de la planificación automática es la expansión de árboles de búsqueda muy grandes. Es por eso que hay que tratar de limitar la búsqueda lo máximo posible en el dominio incluyendo a veces precondiciones innecesarias que, aunque parezcan un poco absurdas, ayudan a que este árbol no se expanda tanto. También hay que tener cuidado con cuestiones como el orden en que se introducen los *exists* y *forall*, dado que puede influir mucho en la capacidad de búsqueda y de poda del algoritmo.

​	Además, otra problemática que puede presentar la planificación automática (que me he encontrado durante el desarrollo de la práctica debido a fallos que posteriormente he solucionado) es que, en determinadas ocasiones, cuando se expanden árboles de búsqueda muy grandes, en el caso de que el objetivo planteado sea inalcanzable, la comprobación de que este objetivo es inalcanzable se vuelve más costosa que el hecho de encontrar un plan que lo satisfaga.
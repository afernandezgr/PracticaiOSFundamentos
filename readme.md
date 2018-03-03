# Práctica Fundamentos de iOS Mobile Bootcamp VI



## Notas sobre la implementación

**Punto 1**

Se crean las clases Season y Episode poniendo especial cuidado de no crear un ciclo entre ambas clases relacionadas (lo que impediría que el ARC pudiese hacer su trabajo al no disminuir nunca el contador de referencias).

Para ello la referencia de Episode a Season se marca como weak.

Según se confirma en el foro de Slack se puede generar la Season con una lista de 0 episodios.

**Punto 2**
Se implementan los protocolos indicados en la práctica creando sus tests correspondientes

* CustomStringConvertible
* Equatable
* Hashable
* Comparable

**Punto 3**

Siguiendo el procedimiento utilizado para el Repository.local de House creamos una estructura similar para las Temporadas y Episodios correspondientes.

Los datos son recuperados de la Wikipedia , de las 7 termporadas incluyendo 2 episodios por cada una

**Punto 4**

Implementamos una función similar a la de Houses para Seasons que acepta una clausura y permite recibir en lugar de un House un Season

**Punto 5**

Implementamos un SeasonListViewController que al hacer un push sobre una de las Seasons hace que se haga un push para mostrar el detalle de la temporada.

**Punto 6**

Similar al punto 5 pero para el caso de listas de episodios y detalles de episodio

**Punto 7**

Implementamos el agrupado de VC tal y como se especifica en el enunciado.
Hacemos que AppDelegate extienda el protocolo de UITabBarControllerDelegate para podamos gestionar el método que gestiona el la selección de una de las tabs.
Hacemos que el delegate de la TabBar sea la propio AppDelegate.

En el método del didSelect lo que hacemos es detectar el VC que ha provocado la selección y posteriormente lo que hacemos es modificar de forma dinámica el DetailView del SplivVC con el método .showDetailViewController del splitVC.
Vamos llevando el control de si está o no esta colapsado el splivVC

Hacemos que AppDelegate implemente tambien el protocolo UISplitViewControllerDelegate para controlar los comportamiento del splitVC cuando colapsa.

Las estructura seguida ha sido:
Para los cosas es en que nos hemos podido valer tan solo con el delegate (un objeto solo puede tener un delegado) hemos usado este procedimiento pero si había que 'avisar' a mas de un VC hemos empleado notificaciones.

**Punto 8**

Para implementar el punto 8 hemos generado un tipo enum, 'Houses' , para tener controlado el número de casas posible y asegurarnos que no cometemos errores al escribir, además el IDE nos asiste a la hora de elegir solamente valores válidos.

**Punto 9**

Este punto ha sido solventado con notificaciones. Se controla que si se cambia una casa o una temporada estándo ya en un nivel avanzado de detalle (EpisodeDetail o MemberDetail) hacemos un pop hasta el rootViewController para que tenga consistencia entre lo mostrado entre las masterVC la detailVC del splitVC.

**Punto 10**

Se ha implementado siguiendo un procedimiento a los seguidos anteriormente, hemos incluido un control de la notificación de cambio de houses para que si se produce se haga un pop hasta el rootViewController , con el fin de que tenga consistencia los mostrado en masterVC y detailVC del splitVC.

***

Adolfo Fernández 
2018


# test-rappi-movies
# Mobile Assignment Rappi

This is a test to see my performance to Rappi company.
A simple application using the TheMovieDB API.

## Starting 🚀

_I decided to use git flow to manage the branches_

### Tasks 📋

1. **Consumir el API de películas y series de la siguiente pagina: themoviedb.org**
2. **Debe tener tres categorías de películas y/o series: Popular, Top Rated, Upcoming.**
3. **Cada película y/o series debe poder visualizar su detalle.**
4. **Debe funcionar tanto online como offline (cache).**
5. **Debe tener un buscador offline por categorías.** 


## Additional Requirements And Restrictions: 📦 ⚙️

- * iOS - 14.0 +
- Clean architecture
- Tests/UITests
- 3rd party libraries

## Capas de la App:
**Source.**
 - ViewController:
    Es el encargado del diseño de la pantalla y llamar la lógica de negocio para que el usuario final veo un buen comportamiento.
 - Presenter:
    Es el encargado de entregarle a la capa de diseño los datos necesarios a mostrar.
 - Worker:
    Nos ayuda a ir a buscar la información deseada, ya sea que este guardada localmente en el dispositivo o llamar un API.
 - Models:
    Almacena los interpretadores de comunicación entre las capas
 - Interactor:
    Es el interprete principal entre las capas, osea que es el que tiene cominicacion con todo el Escenario para cumplir la funcionalidad de una pantalla.

**¿En qué consiste el principio de responsabilidad única? ¿Cuál es su propósito?**
**R:** Que la lógica este encapsulada en una sola clase.
     El proposito es tener mas entendimiento y flexibilidad para el mantenimiento del software.


**Qué características tiene, según su opinión, un “buen” código o código limpio**
**R:** Que la estructura de las pantallas este dividida en capas, respetar los guidelines de cada sistema operativo, tener por lo menos los fundamentos basicos de patrones de diseño y OOP.

## Build it with 🛠️

* [Clean Swift](https://clean-swift.com) - Architecture
* [Rx](https://github.com/ReactiveX/RxSwift) - Reactive
* [SDWebImage](https://github.com/SDWebImage/SDWebImage) - Images


---
⌨️ con ❤️ por [BodoqueZorrilla](https://www.linkedin.com/in/sergio-eduardo-zorrilla-arellano-78bb0994/) 😊

# interacción entre un anillo de protones y un electrón

Simulación de un electrón en interacción con un anillo de protones, donde solamente esta presenta la fuerza electromagnética. 

Programado en Fortran, cuenta con 2 módulos, una subrutina y el programa principal:


Principal: 

* Interaccion_anillocargadoVsElectron.f90


módulos: 

* ModFuncioncargado.f90 crea objetos tipo partícula y un objeto que cargara datos de la simulación.
* ModFuncionvectores.f90 calcula la magnitud de un vector con 3 componentes.

Subrutina:

* anillo.f90 crea un anillo de partículas sin cargar.


Como salida tenemos 3 archivos .dat donde estarán la posición del electrón, trayectoriaElectron.dat, sus energías, energias.dat, y las posiciones del anillo, anilloCargado.dat. Además, una imagen donde estará la trayectoria tomada por el electrón en el intervalo de tiempo, trayectoria.png.

<p align="center" width="100%">
    <img width="50%" src="https://user-images.githubusercontent.com/91238149/230496516-db8aeb81-ef8f-4cc2-a5b6-e6500e85533e.png">
</p>


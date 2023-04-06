PROGRAM AnilloProtones_Contra_Electron

  USE objetos_cargados
  USE funciones_vectores
  

  IMPLICIT NONE

  !! Definiendo variables locales.
 
  REAL(d) :: t                          !! Instante de tiempo en cada aproximacion.
  REAL(d) :: EK,EP,EM                   !! Energias cinetica, potencial y mecanica.
  REAL(d) :: scale = 1E9                !! Escalar longitudes en los plots.
  REAL(d) :: runit(3)                   !! Vector unitario.
  INTEGER :: unito                      !! Unidad para archivo de salida.
  REAL(d) :: r                          !! Radio del anillo.
  INTEGER :: n                          !! Numero de protones del anillo. 
  REAL(d) :: FNelec(3)                  !! Fuerza electrica neta.
  INTEGER :: i,j                        !! Contador.


  TYPE(particula_cargada), ALLOCATABLE :: anillocargado(:)  !! Anillo de protones.

  TYPE(particula_cargada) :: electron                !! Objeto tipo particula cargada: electron.

  TYPE(data) :: sim                                  !! Objeto con informacion de la simulacion.


  !! Valores necesarios para crear el anillo.

  r = 1.1                                         !! Radio del anillo.

  n = 250                          !! Numero de puntos que formaran el anillo.


ALLOCATE(anillocargado(n))


WRITE(*,*)'   ===================================================== '
WRITE(*,*)'    '
WRITE(*,*)'   Se modelará un anillo cargado uniformemente como un ' 
WRITE(*,*)'   conjunto de cargas puntuales colocadas en un círculo.' 
WRITE(*,*)'   El anillo fue colocado en el plano yz de manera que ' 
WRITE(*,*)'   eje coincida con el eje de las x.'
WRITE(*,*)'   Se asıgnó una carga total Q = 50 × 10⁻⁹ C y un radio '
WRITE(*,*)'   de R = 0.1 m. '
WRITE(*,*)'    '
WRITE(*,*)'   ====================================================='
WRITE(*,*)'   '
WRITE(*,*)'   '



  !! Subrutina para calcular las posiciones de los protones.


  CALL anillo(r,n,anillocargado)      !! Anillo en 3D, centrado en el eje x, con radio r y numero de puntos n.


  !! Asignando valores fisicos a los protones (MKS).

     anillocargado%mass = 1.7E-27_d               !! Masa del proton.
     anillocargado%q = (50E-9_d)/n                !! Carga del proton.


  !! Asignando valores fisicos al electron (MKS).

     electron%mass = 9.1E-31_d       !! Masa del electron.
     electron%q = -1.6E-19_d         !! Carga del electron.

  !! Construyendo el vector de velocidad inicial del electron.

     electron%vel = vector(0.05_d,0.05_d,-0.1_d)

  !! Construyendo el vector de posicion inicial del electron.

     electron%pos = vector(0.02_d,-0.02_d,-0.05_d)

  !! Construyendo el vector de momento lineal inicial del electron.

     electron%mom = electron%mass * electron%vel


  !! Campo electrico del electron.

     electron%Eelec = 0.0_d

  !! Ajustando el tamaño de paso (cantidad de veces en las que se actualizara la
  !! informacion del sistema).

     sim%N_step = 2000	                !! Numero de pasos.
     sim%ttot = 1E-6_d                  !! En este ejemplo se realizara la evolucion.
                                        !! durante unos segundos.
     sim%dt = sim%ttot / sim%N_step     !! Calculando el ancho de paso.




 !! Abriendo el archivo de texto para escribir las posiciones del electron.

  OPEN ( NEWUNIT = unito, FILE = "trayectoriaElectron.dat", ACTION = "write", STATUS = "unknown" )

  t = 0  !! La simulacion inicia al tiempo 0


  !! Repetir el proceso hasta que se cumpla la condicion.


  DO

     IF ( t > sim%ttot ) EXIT


     DO i = 1,n

  
     !! Calculando la diferencia de posicion entre el electron y el i-esimo proton.

     sim%difr = electron%pos - anillocargado(i)%pos        
     

    !!Vector unitario 

    runit = sim%difr / mag(sim%difr)


     !! Calculando la fuerza electrica que genera el i-esimo proton contra el electron.

     anillocargado(i)%Eelec = (k*anillocargado(i)%q / mag(sim%difr)**2) * runit  
   
     anillocargado(i)%Felec = electron%q * anillocargado(i)%Eelec


    END DO

     !! Calcular la fuerza neta de los protones en el electron.


     FNelec = 0.0 


     DO j = 1,3

        DO i = 1,n

           FNelec(j) = FNelec(j) + anillocargado(i)%Felec(j)

        END DO

      END DO


     !! Actualizando el momento lineal del electron.

      DO i = 1,3
    
        electron%mom(i) = electron%mom(i) + FNelec(i) * sim%dt  

      END DO


     !! Calculando las energias; cinetica, potencial y mecanica.

      OPEN(1,FILE ="energias.dat",STATUS="UNKNOWN")

        EP = mag(FNelec) * mag(sim%difr)

        EK = 0.5 * electron%mass * (mag(electron%mom)/electron%mass)**2

        EM = EP + EK

	
       WRITE(1,*) t, EK,EP,EM


        


     !! Actualizando la posicion del electron.

        electron%pos = electron%pos + electron%mom * sim%dt / electron%mass



     WRITE ( unito,* ) t, electron%pos               !! Escribiendo en el archivo.


     t = t + sim%dt                                  !! Actualizando el tiempo.

  END DO

  CLOSE( unito )





  !! Este archivo sirve para la informacion del anillo de protones.

  OPEN ( NEWUNIT = unito, FILE = "anilloCargado.dat",ACTION = "write", STATUS = "UNKNOWN" )

   DO i = 1,n
  
  WRITE(unito,*) anillocargado(i)%pos(1), anillocargado(i)%pos(2), anillocargado(i)%pos(3) 

  END DO

  CLOSE ( unito )





!==================================================================================
!IMAGEN
	OPEN(20,FILE="dibujar.plt",STATUS="UNKNOWN")
		WRITE(20,*)'unset key'
		WRITE(20,*)'set title "interacción electrón-anillo de protones"'
		WRITE(20,*)'set xlabel "X"'
		WRITE(20,*)'set ylabel "Y"'
        WRITE(20,*)'set zlabel "Z"'
        WRITE(20,*)'set terminal png'
        WRITE(20,*)'set output "trayectoria.png"'
		WRITE(20,*)'splot "trayectoriaElectron.dat" u 2:3:4,"anilloCargado.dat"'
Close(20)
CALL system('gnuplot -p "dibujar.plt"')  
!=====================================================================================

END PROGRAM 

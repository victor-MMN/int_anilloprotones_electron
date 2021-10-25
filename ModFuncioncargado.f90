MODULE objetos_cargados

  IMPLICIT NONE

  SAVE

  !! Constantes importantes para el programa

  
  !! Kind con una precision de 16 para mayor resolucion en el sistema.

  INTEGER, PARAMETER :: d =  SELECTED_REAL_KIND(16)


  !! Introduciendo las unidades naturales del sistema.

  REAL(d), PARAMETER :: pi = 3.14159265358979_d    !! Pi con este kind

  REAL(d), PARAMETER :: k = 9E9_d                  !! k con este kind


  !! Tipo publico para producir objetos del tipo particula.


  TYPE, PUBLIC :: particula_cargada

     REAL(d) :: pos(3)        ! Posicion en el tiempo t.
     REAL(d) :: mom(3)        ! Momento lineal en el tiempo t.
     REAL(d) :: vel(3)        ! Velocidad en el tiempo t.
     REAL(d) :: Felec(3)      ! Fuerza electrica en el tiempo t.
     REAL(d) :: Eelec(3)      ! Campo electrico en el tiempo t.
     REAL(d) :: mass          ! Masa de la particula cargada.
     REAL(d) :: q             ! Carga de la particula.
    


  END TYPE particula_cargada


  !! Tipo publico para producir objetos del tipo estrella

  TYPE, PUBLIC :: data

     REAL(d) :: ttot                         ! Tiempo total de la simulacion.
     REAL(d) :: dt                           ! Tamaño de paso.
     REAL(d) :: N_step                       ! Cantidad de pasos.
     REAL(d) :: difr(3)                      ! Vector donde se guarda la diferencia de
    					     ! posicion entre los objetos.

  END TYPE data


END MODULE objetos_cargados

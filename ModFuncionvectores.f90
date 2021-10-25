!! Este modulo es para hacer algunas operaciones de vectores que puede ser
!! de utilidad.


MODULE funciones_vectores

  USE objetos_cargados

  IMPLICIT NONE



CONTAINS

  !! Esta funcion sirve para rellenar los elementos del arreglo sin declaracion
  !! explicita de los indices.


  FUNCTION vector (xo,yo,zo)

    
    IMPLICIT NONE

    REAL(d) :: xo,yo,zo,vector(3)

    vector(1) = xo
    vector(2) = yo
    vector(3) = zo

  END FUNCTION vector

  !! Funcion construida para calcular la magnitud de un vector de 3D.

  FUNCTION mag(xo)

    IMPLICIT NONE

    REAL(d) :: xo(3),mag


    mag = SQRT(xo(1)**2 + xo(2)**2 + xo(3)**2)


  END FUNCTION mag


END MODULE funciones_vectores

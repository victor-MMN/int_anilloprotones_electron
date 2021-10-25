!! Subrutina para crear un anillo de particulas sin cargar (se cargara en el programa principal).


SUBROUTINE anillo(r,n,anillocargado)


  USE objetos_cargados


  IMPLICIT NONE


  REAL(d) :: i = 0,rad
  INTEGER :: j = 1
  REAL(d), INTENT(IN) :: r
  INTEGER, INTENT(IN) :: n  
  TYPE(particula_cargada), INTENT(INOUT) :: anillocargado(n)


  rad =  2*pi/n

   DO 

     IF ( i >= 2*pi ) EXIT

     anillocargado(j)%pos(1) = 0
     anillocargado(j)%pos(2) = r*COS(i)
     anillocargado(j)%pos(3) = r*SIN(i) 

     i = i + rad
  
     j = j + 1 
   
  END DO


END SUBROUTINE anillo




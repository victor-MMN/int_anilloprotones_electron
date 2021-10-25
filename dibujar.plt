 unset key
 set title "Electrón rodeado por campo electrico"
 set xlabel "X"
 set ylabel "Y"
 set zlabel "Z"
 set terminal png
 set output "Trayectoria.png"
 splot "TrayectoriaElectron" u 2:3:4,"Anillocargado"

 unset key
 set title "interacción electrón-anillo de protones"
 set xlabel "X"
 set ylabel "Y"
 set zlabel "Z"
 set terminal png
 set output "trayectoria.png"
 splot "trayectoriaElectron.dat" u 2:3:4,"anilloCargado.dat"

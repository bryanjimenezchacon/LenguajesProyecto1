from itertools import permutations
from time import time

def nReinas(n):
    columnas = range(n)#Verifica que la solucion sea valida
    for tablero in permutations(columnas):
        if n == len(set(tablero[i] + i for i in columnas)) \
             == len(set(tablero[i] - i for i in columnas)):
                yield tablero

def imprimirSoluciones(n):#Muestra la Solucion graficamente, recibiendo el resultado de nReinas(n)
    tablero_sep, tablero_top = "\n", "+" + "-+" * n
    linea = "+" + "-+" * n
    for tablero in nReinas(n):
        #print(tablero_top)
        for l in tablero:
            print(linea)
            print ("|" + " |" * l + "X|" + " |" * (n - l - 1))

        print(linea)
        print(tablero_sep)
#---------------------------------------------------------#
imprimirSoluciones(4)#Muestra tableros para n reinas
 
#Muestra el tiempo y cantidad de soluciones para cada problema
ph = "Solucion del problema con %2d reina(s): %5d solucion(es) en %9.3f segundos"
for n in range (4, 11):
    t0= time()
    lr = len(list(nReinas(n)))
    t1 = time ()
    print(ph % (n, lr, t1 -t0))


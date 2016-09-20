from itertools import permutations
from time import time

def nReinas(n):
    columnas = range(n)
    for tablero in permutations(columnas):
        if n == len(set(tablero[i] + i for i in columnas)) \
             == len(set(tablero[i] - i for i in columnas)):
                yield tablero

def imprimirSoluciones(n):
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
imprimirSoluciones(4)#Muestra el tablero
 
#Muestra el tiempo 
ph = "Solucion del problema de la   %2d reinas: %5d soluciones (%9.3f segundos)"
for n in range (1, 9):
    t0= time()
    lr = len(list(nReinas(n)))
    t1 = time ()
    print(ph % (n, lr, t1 -t0))


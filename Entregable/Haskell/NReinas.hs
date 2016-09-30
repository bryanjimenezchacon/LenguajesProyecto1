module Main where
import Data.List ((\\))

type Tablero = [Int]  
-- Recibe la cantidad de reinas y devuelve 
--la Lista con las soluciones utilizando una funcion auxiliar
reinas :: Int -> [Tablero]
reinas n = aux n
    where aux 0 = [[]]
          aux m = [r:rs | rs <- aux (m-1),
                          r <- ([1..n] \\ rs),
                          noAtaca r rs 1]
-- Asegura que la reina r no ataca a niguna de las demas de la lista rs. 
noAtaca :: Int -> Tablero -> Int -> Bool
noAtaca _ [] _ = True
noAtaca r (a:rs) distH = abs(r-a) /= distH &&
                         noAtaca r rs (distH+1)
--Dibuja una solucion en pantalla
dibujaSol :: [Int] ->  IO ()
dibujaSol [] = putStrLn "No hay mas soluciones"
dibujaSol x = do
        let size = length x
        let largoSol = length x
        let lista = reverse x
        let fila size = concat $ replicate size "-+"

        let spaces n = concat $ replicate n " |"
        let filaReinas n = "|" ++spaces (n - 1) ++ "X|" ++ spaces (size - n)

        let recorre p = if p>= 0 then filaReinas (lista!!p) ++ "\n" ++ "+" ++ fila (length x) ++ "\n" ++ recorre(p-1) else ""
        let cantidad_elementos = largoSol - 1
         in putStrLn ("+" ++ fila (length x) ++ "\n" ++ recorre cantidad_elementos)

--Recorre la lista de soluciones e invoca a dibujaSol para cada una
dibujaTableros :: [[Int]] ->  IO ()
dibujaTableros [[]] = dibujaSol []
dibujaTableros x = do
        if length(x) > 0
           then do dibujaSol (x!!0) 
                   dibujaTableros(tail x)
        else dibujaSol []
--Main
main :: IO ()
main  =
    do
      putStrLn "Incio"
      dibujaTableros (reinas 4)
      putStrLn "FIN"

 -- Para medir el tiempo usar :set +s en consola y luego invocar length(reinas n)
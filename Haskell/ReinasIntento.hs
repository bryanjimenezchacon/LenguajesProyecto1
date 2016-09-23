module Main where
import Data.List ((\\))
 
-- El tablero se representa por una lista de números que indican las
-- filas donde se han colocado las reinas. Por ejemplo, [3,5]
-- indica que se han colocado las reinas (1,3) y (2,5). 
type Tablero = [Int]  
 
-- (reinas n) es la lista de soluciones del problema de las N
-- reinas. Por ejemplo, 
--    reinas 4  == [[3,1,4,2],[2,4,1,3]].  
-- La primera solución [3,1,4,2] se interpreta como 
--    +---------------+
--    |   | R |   |   |
--    +---------------+
--    |   |   |   | R |
--    +---------------+
--    | R |   |   |   |
--    +---------------+
--    |   |   | R |   |
--    +---------------+


reinas :: Int -> [Tablero]
reinas n = aux n
    where aux 0 = [[]]
          aux m = [r:rs | rs <- aux (m-1),
                          r <- ([1..n] \\ rs),
                          noAtaca r rs 1]
-- (noAtaca r rs d) se verifica si la reina r no ataca a niguna de las
-- de la lista rs donde la primera de la lista está a una distancia
-- horizontal d. 
noAtaca :: Int -> Tablero -> Int -> Bool
noAtaca _ [] _ = True
noAtaca r (a:rs) distH = abs(r-a) /= distH &&
                         noAtaca r rs (distH+1)

drawQueens :: [Int] ->  IO ()
drawQueens [] = putStrLn "No hay mas soluciones"
drawQueens x = do
        let size = length x
        let largoSol = length x
        let lista = reverse x
        let fila size = concat $ replicate size "-+"

        let spaces n = concat $ replicate n " |"
        let filaReinas n = "|" ++spaces (n - 1) ++ "X|" ++ spaces (size - n)

        let recorre p = if p>= 0 then filaReinas (lista!!p) ++ "\n" ++ "+" ++ fila (length x) ++ "\n" ++ recorre(p-1) else ""
        let cantidad_elementos = largoSol - 1
         in putStrLn ("+" ++ fila (length x) ++ "\n" ++ recorre cantidad_elementos)

dibujaTableros :: [[Int]] ->  IO ()
dibujaTableros [[]] = drawQueens []
dibujaTableros x = do
		if length(x) > 0
		   then do drawQueens (x!!0) 
		           dibujaTableros(tail x)
		else drawQueens []

main :: IO ()
main  =
    do
      putStrLn "Incio"
      dibujaTableros (reinas 4)
      putStrLn "FIN"
 
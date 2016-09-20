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

drawQueens :: [Int] -> String
drawQueens [] = "No hay soluciones"
drawQueens x = concatMap showRow x
    where
        size = length x
        spaces n = concat $ replicate n "  "
        showRow n = spaces (n - 1) ++ "X " ++ spaces (size - n)
						 
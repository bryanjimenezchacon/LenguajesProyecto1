import Data.List 

-- (noAtaca r rs d) se verifica si la reina r no ataca a niguna de las 
-- de la lista rs donde la primera de la lista está a una distancia 
-- horizontal d.
	  
noAtaca :: Int -> [Int] -> Int -> Bool 
noAtaca _ [] _ = True 
noAtaca r (a:rs) distH = abs(r-a) /= distH && 
                         noAtaca r rs (distH+1) 

						 
-- (reinas n) es la lista de soluciones del problema de las N 
-- reinas. Por ejemplo,  
--    reinas 4  == [[3,1,4,2],[2,4,1,3]].  
reinas :: Int -> [[Int]] 
reinas n = aux n 
    where aux 0 = [[]] 
          aux m = [r:rs | rs <- aux (m-1), 
                          r <- ([1..n] \\ rs), 
                          noAtaca r rs 1] 
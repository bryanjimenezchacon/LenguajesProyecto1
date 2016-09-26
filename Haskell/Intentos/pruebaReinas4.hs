queens :: Int -> [[Int]]
queens 0 = [[]]
queens n = [ x : y | y <- queens (n-1), x <- [1..8], safe x y 1]
     where
         safe x [] n = True
         safe x (y:ys) n = and [ x /= y , x /= y + n , x /= y - n , safe x ys (n+1)]
drawQueens :: [Int] -> String
drawQueens [] = ""
drawQueens x = concatMap showRow x  ++['\n']
    where
        size = length x
        spaces = replicate size ' '
        showRow n = replicate (n - 1) 'm ' ++ "|X" ++ replicate (size - n) 'c'   ++ ['\n']
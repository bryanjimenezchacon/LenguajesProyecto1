    import           Control.Monad
    import           Data.List
    
    queens :: Int -> [[Int]]
    queens n = map fst $ foldM oneMoreQueen ([],[1..n]) [1..n]  where
      oneMoreQueen (y,d) _ = [(x:y, delete x d) | x <- d, safe x]  where
        safe x = and [x /= c + n && x /= c - n | (n,c) <- zip [1..] y]
    printSolution y = do
         let n = length y  
         mapM_ (\x -> putStrLn [if z == x then 'X' else '_' | z <- [1..n]]) y
         putStrLn ""
    
    main = mapM_ printSolution $ queens 4

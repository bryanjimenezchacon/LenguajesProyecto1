import System.Environment

noDiagonal :: (Int, Int) -> (Int, Int) -> Bool
noDiagonal (x1, y1) (x2, y2) = abs(x1 - x2) /= abs(y1 - y2)

solveQueens :: Int -> [Int] -> [[Int]]
solveQueens n yIn
    | length yIn >= n   = [yIn]
    | otherwise         = concatMap (solveQueens n) (map (: yIn) [y | y <- [0..n-1], not $ elem y yIn, all (noDiagonal (-1, y)) inCoords])
    where
        inCoords = zip [0..] yIn

nQueens :: Int -> Int
nQueens n = length $ solveQueens n []

printQueens :: Int -> IO ()
printQueens n = putStrLn $ "Nr. of solutions with n = " ++ (show n) ++ ": " ++ (show (nQueens n))

main :: IO ()
main = do
    args <- getArgs
    let n = read $ head args :: Int
    printQueens n
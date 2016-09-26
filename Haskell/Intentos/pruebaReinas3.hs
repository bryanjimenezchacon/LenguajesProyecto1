import System.Environment (getArgs)

data Board = Board {
  field :: [Int],
  size :: Int
}

-- | Checks whether the board has a conflict
conflict :: Board -> Bool
conflict b = any (==x) xs || step (-1) x xs || step 1 x xs
  where (x:xs) = field b
        step _ _ [] = False
        step s p (x:xs)
          | (s+p) == x = True
          | otherwise  = step (s+p) p xs

-- | Returns all boards one can get by placing a queen in the next column
place :: Board -> [Board]
place b = place' b 1
  where place' b s
          | s > size b        = []
          | conflict newboard = rest
          | otherwise         = newboard:rest
          where newboard = Board newfield (size b)
                newfield = s:(field b)
                rest     = place' b (s+1)

-- | Returns all boards one can get for the n-th queen problem
placeAll :: Int -> [Board]
placeAll n = foldl (>>=) [Board [] n] (replicate n place)

-- | Creates a String from a board
prettyPrint :: Board -> String
prettyPrint b = unlines.map prettyLine.field$b
  where prettyLine n = replicate (n - 1) '.' ++ "@" ++ replicate ((size b) - n) '.'

-- | Shows the first two solutions obtained by placeAll
main = do
  [s] <- getArgs
  mapM_ putStrLn . map prettyPrint . take 2 . placeAll . read $ s
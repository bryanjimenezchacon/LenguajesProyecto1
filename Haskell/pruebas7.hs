-- nqueens.hs
-- Mike Vollmer, 2014
--
-- A simple and reasonably efficient solution to the N-Queens problem using backtracking
-- and constraint propagation.
--
-- The program takes one command line parameter: the size (N) of the board.
-- For example:
-- 
--   ./nqueens 8

import qualified Data.List as List
import Data.Set as Set
import Data.Sequence((<|), (|>), (><), ViewL(..), ViewR(..))
import qualified Data.Sequence as Sequence
import Control.Monad (forM_)
import Data.Foldable (toList)
import System.Environment   

-- use bitsets to represent domains of columns on the board
type Domain   = Set.Set Int

-- a solution candidate is a sequence of integers
type Solution = Sequence.Seq Int

-- construct a new list of domains (all possible places for a queen in each column)
makeDomains :: Int -> [Domain]
makeDomains n = replicate n (Set.fromList [1..n])

-- iterate through the domains for each column and remove entries
filterByFunc :: Int -> (Int -> Int) -> [Domain] -> [Domain]
filterByFunc _ _ []     = []
filterByFunc n f (x:xs) = Set.delete n x : filterByFunc (f n) f xs

-- use filterByFunc to remove entries horizontally and diagonally
filterDomains :: Int -> [Domain] -> [Domain]
filterDomains n d = tailOrNil $ filtered d
  where filtered  = filterByFunc n id     .
                    filterByFunc n ( 1 +) .
                    filterByFunc n (-1 +)
        tailOrNil l
          | List.null l = []
          | otherwise   = tail l

-- branch/search: mutually recursive functions for doing depth first search
-- nQueensBranch takes a particular row position and fixes it, recursing on the next column
nQueensBranch :: Int -> [Domain] -> Int -> Solution
nQueensBranch _ [] _ = Sequence.empty
nQueensBranch n l p  = p <| nQueensSearch (n - 1) newDomain
  where newDomain    = filterDomains p l

-- iterate through different row options for current column
nQueensSearch :: Int -> [Domain] -> Solution
nQueensSearch _ [] = Sequence.empty
nQueensSearch n l  = select $ Set.toList $ head l
  where
    select []      = Sequence.empty
    select (x:xs)  = if Sequence.length branch == n
                    then branch
                    else select xs
      where branch = nQueensBranch n l x
  
-- run the search for an n by n board
nQueens :: Int -> Solution
nQueens n = nQueensSearch n $ makeDomains n

-- print the board to the console
printBoard :: [Int] -> Int -> IO ()
printBoard b n = 
  forM_ b (\i -> do
             forM_ (replicate (i - 1) "- ") putStr
             putStr "Q "
             forM_ (replicate (n - i) "- ") putStr
             putStr "\n")

main :: IO ()
main = do
  args <- getArgs
  let n = read $ head args :: Int
      b = Data.Foldable.toList $ nQueens n
  printBoard b n
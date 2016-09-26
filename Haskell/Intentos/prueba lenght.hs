le                  :: [[Int]] ->  IO ()
le [[]] = putStrLn ("+")
le (x:xs)           =  [] + le xs
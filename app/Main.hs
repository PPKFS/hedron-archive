module Main (main) where

import HedronArchive (projectName)


main :: IO ()
main = putStrLn ("Executable for " ++ projectName)

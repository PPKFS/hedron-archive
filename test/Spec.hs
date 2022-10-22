module Main (main) where

import HedronArchive (projectName)


main :: IO ()
main = putStrLn ("Tests for " ++ projectName)

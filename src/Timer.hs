module Timer
    ( convert
    ) where

import Helper
import Data.Char(isDigit)

convert :: [Char] -> [Char]
convert num 
    | not $ checkNum num = "error"
    | len > 4 = "error" 
    | len == 0 = "error" 
    | not $ validate list = "error" 
    | otherwise = display list
    where len = length num
          list = format num

checkNum :: String -> Bool
checkNum = all isDigit

validate :: [Int] -> Bool 
validate list = x < 6 && y < 6
    where x = list!!0  
          y = list!!2

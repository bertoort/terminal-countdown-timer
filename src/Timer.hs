module Timer
    ( convert
    ) where

import Data.List (intercalate)
import Data.Char (isDigit)

data InvalidNumber = InvalidNumber Int String

instance Show InvalidNumber where
    show (InvalidNumber num err) = show num ++ " - " ++ err

convert :: [Char] -> [Char]
convert num 
    | not $ checkNum num = "error"
    | len > 4 = "error" 
    | len == 0 = "error" 
    | not $ validate list = "error" 
    | otherwise = display list
    where len = length num
          list = format num

format :: [Char] -> [Int] 
format num = do
    let list = map (read . (:"")) num :: [Int]
    lpad 4 list

checkNum :: String -> Bool
checkNum = all isDigit

lpad :: Int -> [Int] -> [Int]
lpad m xs = replicate (m - length ys) 0 ++ ys
    where ys = take m xs

display :: [Int] -> [Char]
display xs = do
    let (ys,zs) = splitAt 2 xs
    join ys ++ ":" ++ join zs 

join :: [Int] -> [Char]
join xs = intercalate "" $ map show xs

validate :: [Int] -> Bool 
validate list = x < 6 && y < 6
    where x = list!!0  
          y = list!!2
    

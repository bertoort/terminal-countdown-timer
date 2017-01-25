module Helper
    ( display
    , format
    ) where

import Data.List(intercalate)

display :: [Int] -> [Char]
display xs = do
    let (ys,zs) = splitAt 2 xs
    join ys ++ ":" ++ join zs 

join :: [Int] -> [Char]
join xs = intercalate "" $ map show xs

format :: [Char] -> [Int] 
format num = do
    let list = map (read . (:"")) num :: [Int]
    lpad 4 list

lpad :: Int -> [Int] -> [Int]
lpad m xs = replicate (m - length ys) 0 ++ ys
    where ys = take m xs

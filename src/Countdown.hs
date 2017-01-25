module Countdown
    ( countdown
    ) where

import Helper 

countdown :: [Char] -> [Char]
countdown time = display $ nextTick (format nums) 3
    where nums = take 2 time ++ drop 3 time

nextTick :: [Int] -> Int -> [Int]
nextTick nums i
    | current > 0 = replace i (subtract 1 current) nums
    | next == -1 = [0,0,0,0]
    | otherwise = nextTick (subtractFromZero nums i) next 
    where current = nums!!i
          next = subtract 1 i 

subtractFromZero :: [Int] -> Int -> [Int]
subtractFromZero nums i
    | odd i = replace i 9 nums 
    | otherwise = replace i 5 nums

replace :: Int -> Int -> [Int] -> [Int]
replace n newVal (x:xs)
    | n == 0 = newVal:xs
    | otherwise = x:replace (n-1) newVal xs

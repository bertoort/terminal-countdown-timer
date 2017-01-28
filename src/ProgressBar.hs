module ProgressBar 
    ( progressBar ) where

import Countdown
import Control.Monad
import Control.Concurrent
import System.IO
import Text.Printf
import Data.Maybe 
import Data.Map 
import qualified Data.Map as Map

putProgress :: String -> IO ()
putProgress s = hPutStr stderr $ "\r\ESC[K" ++ s

drawProgressBar :: Int -> Int -> String
drawProgressBar width progress =
  " ╢" ++ replicate bars '█' ++ replicate spaces '░' ++ "╟"
  where bars = (progress * width) `div` 100
        spaces = width - bars

drawPercentage :: Int -> String
drawPercentage progress = printf "%3d%%" progress

drawTime :: Int -> String -> String
drawTime secs time = printf $ clock secs ++ "  " ++ time

tick :: String -> Int -> Int -> IO ()
tick time secs total
  | secs /= total = do
      let progress = ((100 * secs) `div` total) 
      putProgress $ drawTime secs time ++ drawProgressBar 50 progress ++ " " ++ drawPercentage progress
      threadDelay 1000000
      tick (countdown time) (secs + 1) total 
  | otherwise = do
      putStr "\a"
      putProgress "Time's Up 🏁"
      hPutChar stderr '\n'

progressBar :: String -> IO ()
progressBar time = do
  tick time 0 $ getSeconds time 

clock :: Int -> [Char] 
clock n = do
    let e = Map.fromList [(0, "🕛"),(1, "🕐"), (2, "🕑"), (3, "🕒"), (4, "🕓"), (5, "🕔"),
                          (6, "🕕"), (7, "🕖"), (8, "🕗"), (9, "🕘"), (10, "🕙"), (11, "🕚")]
    fromJust $ Map.lookup (n `mod` 12) e

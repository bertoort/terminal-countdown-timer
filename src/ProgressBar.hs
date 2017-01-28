module ProgressBar 
    ( progressBar ) where

import Countdown
import Control.Monad
import Control.Concurrent
import System.IO
import Text.Printf

putProgress :: String -> IO ()
putProgress s = hPutStr stderr $ "\r\ESC[K" ++ s

drawProgressBar :: Int -> Int -> String
drawProgressBar width progress =
  " ╢" ++ replicate bars '█' ++ replicate spaces '░' ++ "╟"
  where bars = (progress * width) `div` 100
        spaces = width - bars

drawPercentage :: Int -> String
drawPercentage progress = printf "%3d%%" progress

drawTime :: String -> String
drawTime time = printf "⏰  " ++ time 

tick :: String -> Int -> Int -> IO ()
tick time secs total
  | secs /= total = do
      let progress = ((100 * secs) `div` total) 
      putProgress $ drawTime time ++ drawProgressBar 50 progress ++ " " ++ drawPercentage progress
      threadDelay 1000000
      tick (countdown time) (secs + 1) total 
  | otherwise = do
      putStr "\a"
      putProgress "Time's Up 🏁"
      hPutChar stderr '\n'

progressBar :: String -> IO ()
progressBar time = do
  tick time 0 $ getSeconds time 

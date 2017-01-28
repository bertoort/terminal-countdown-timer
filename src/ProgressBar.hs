module ProgressBar 
    ( progressBar ) where

import Countdown
import Control.Monad
import Control.Concurrent
import System.IO
import Text.Printf

putProgress :: String -> IO ()
putProgress s = hPutStr stderr $ "\r\ESC[K" ++ s

drawProgressBar :: Int -> Rational -> String
drawProgressBar width progress =
  " ╢" ++ replicate bars '█' ++ replicate spaces '░' ++ "╟"
  where bars = round (progress * fromIntegral width)
        spaces = width - bars

drawPercentage :: Rational -> String
drawPercentage progress = printf "%3d%%" (truncate (progress * 100) :: Int)

drawTime :: String -> String
drawTime time = printf "⏰ " ++ time 

tick :: String -> Int -> IO ()
tick time i
  | i > 0 = do
      let progress = fromIntegral i / 100
      putProgress $ drawTime time ++ drawProgressBar 50 progress ++ " " ++ drawPercentage progress
      threadDelay 1000000
      tick (countdown time) (subtract 1 i) 
  | otherwise = do
      putStr "\a"
      putProgress "Time's Up 🏁"
      hPutChar stderr '\n'

progressBar :: String -> IO ()
progressBar time = do
  tick time $ getSeconds time 

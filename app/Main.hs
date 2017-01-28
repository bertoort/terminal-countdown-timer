module Main where

import Timer
import Countdown
import ProgressBar
import Options.Applicative
import Control.Monad (unless)
import Control.Concurrent(threadDelay)

data ArgParser = ArgParser
  { argtime :: String }

parser :: Parser ArgParser
parser = ArgParser
     <$> argument str (metavar "[time]")

initiate :: ArgParser -> IO ()
initiate (ArgParser t) = start $ convert t
initiate _ = return ()

start :: [Char] -> IO()
start "error" = putStrLn "Invalid Input"
start time = progressBar time

main :: IO ()
main = execParser opts >>= initiate
  where
    opts = info (helper <*> parser)
      ( fullDesc
     <> progDesc "Starts timer with the given time"
     <> header "timer - a countdown timer for the terminal" )

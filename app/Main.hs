module Main where

import Timer
import Options.Applicative

data ArgParser = ArgParser
  { argtime :: String }

parser :: Parser ArgParser
parser = ArgParser
     <$> argument str (metavar "[time]")

countdown :: ArgParser -> IO ()
countdown (ArgParser t) = putStrLn $ convert t
countdown _ = return ()

main :: IO ()
main = execParser opts >>= countdown
  where
    opts = info (helper <*> parser)
      ( fullDesc
     <> progDesc "Starts timer with the given time"
     <> header "timer - a countdown timer for the terminal" )

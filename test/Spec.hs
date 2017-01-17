module Main where

import Test.Hspec
import Timer

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  describe "Timer" $ do
    it "should convert a number into time format" $
      convert "3" `shouldBe` "00:00:03"

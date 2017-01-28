module Main where

import Test.Hspec
import Timer
import Countdown

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  describe "Timer" $ do
    it "should convert a number into time format" $ do
      convert "3" `shouldBe` "00:03"
      convert "12" `shouldBe` "00:12"
      convert "102" `shouldBe` "01:02"
    it "should only accept unsigned integers" $ do
      convert "" `shouldBe` "error"
      convert "  " `shouldBe` "error"
      convert "-12" `shouldBe` "error"
      convert "10s" `shouldBe` "error"
      convert "ten" `shouldBe` "error"
    it "should only accept feasible time" $ do
      convert "79" `shouldBe` "error"
      convert "9200" `shouldBe` "error"
      convert "165" `shouldBe` "error"
    it "should only accept time below an hour (5959)" $ 
      convert "50000" `shouldBe` "error"
  describe "Countdown" $ do
    it "should decrease time by one second" $ do
      countdown "00:04" `shouldBe` "00:03"
      countdown "01:43" `shouldBe` "01:42"
    it "should borrow time from the tenth if the second is at zero" $ do
      countdown "50:50" `shouldBe` "50:49"
      countdown "01:30" `shouldBe` "01:29"
    it "should borrow time from the minute if the tenth is at zero" $ do
      countdown "01:00" `shouldBe` "00:59"
      countdown "19:00" `shouldBe` "18:59"
    it "should borrow time from the tenth minute if the minute is at zero" $ do
      countdown "10:00" `shouldBe` "09:59"
      countdown "40:00" `shouldBe` "39:59"
    it "should should stop the timer when the time is up" $
      countdown "00:00" `shouldBe` "00:00"
    it "should give the total of remaining seconds" $ do
      getSeconds "00:30" `shouldBe` 30
      getSeconds "02:58" `shouldBe` 178
      getSeconds "13:03" `shouldBe` 783

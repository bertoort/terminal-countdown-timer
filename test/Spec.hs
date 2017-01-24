module Main where

import Test.Hspec
import Timer

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

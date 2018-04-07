defmodule Snowcone.EncoderTest do
  use ExUnit.Case

  describe "camelize_keys/1" do
    test "turns string keys into camelized atoms" do
      map = %{"first_f_key" => "value1", "second_key" => "value2"}

      assert(
        Snowcone.Encoder.camelize_keys(map) == 
          %{firstFKey: "value1", secondKey: "value2"}
      )
    end

    test "turns atom keys into camelcased keys" do
      map = %{first_f_key: "value1", second_key: "value2"}

      assert(
        Snowcone.Encoder.camelize_keys(map) ==
          %{firstFKey: "value1", secondKey: "value2"}
      )
    end
  end

  describe "snake_case_keys/1" do
    test "turns string keys into snake cased atoms" do
      map = %{"keyOne" => "first", "keyTwo" => "second"}

      assert(
        Snowcone.Encoder.snake_case_keys(map) == 
          %{key_one: "first", key_two: "second"}
      )
    end

    test "turns atom keyins into snake cased keys" do
      map = %{keyOne: "first", keyTwo: "second"}

      assert(
        Snowcone.Encoder.snake_case_keys(map) ==
          %{key_one: "first", key_two: "second"}
      )
    end
  end
end
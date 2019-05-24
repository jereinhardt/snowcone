defmodule SnowconeTest do
  use ExUnit.Case

  describe "get_works/0" do
    test "returns an array of works when successful" do
      assert {:ok, [%Frost.Work{}]} = Snowcone.get_works
    end
  end

  describe "get_work/1" do
    test "returns a work when successful" do
      assert {:ok, %Frost.Work{}} = Snowcone.get_work(1)
    end
  end

  describe "create_work/1" do
    test "returns success code and blank body when successful" do
      params = %{author: "me", content: "foo", name: "bar", tags: ""}

      assert {:ok, ""} = Snowcone.create_work(params)
    end
  end
end
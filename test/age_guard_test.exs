defmodule AgeGuardTest do
  use ExUnit.Case
  doctest AgeGuard
  alias AgeGuard

  describe "when the person has not enough years," do
    test "date in integers" do
      refute AgeGuard.is_old_enough?(1, 12, 2010, 21)
    end

    test "date in strings (numbers)" do
      refute AgeGuard.is_old_enough?("1", "12", "2010", 21)
    end

    test "date in strings (numbers and short named month)" do
      refute AgeGuard.is_old_enough?("1", "Dec", "2010", 21)
    end

    test "date in strings (numbers and full named month)" do
      refute AgeGuard.is_old_enough?("1", "December", "2010", 21)
    end

    test "date in mix of integers and strings" do
      refute AgeGuard.is_old_enough?(1, "December", 2010, 21)
    end
  end

  describe "when the person has enough years," do
    test "date in integers" do
      assert AgeGuard.is_old_enough?(1, 12, 1995, 21)
    end

    test "date in strings (numbers)" do
      assert AgeGuard.is_old_enough?("1", "12", "1995", 21)
    end

    test "date in strings (numbers and short named month)" do
      assert AgeGuard.is_old_enough?("1", "Dec", "1995", 21)
    end

    test "date in strings (numbers and full named month)" do
      assert AgeGuard.is_old_enough?("1", "December", "1995", 21)
    end

    test "date in mix of integers and strings" do
      assert AgeGuard.is_old_enough?(1, "December", 1995, 21)
    end
  end

  describe "when the date is incorrect," do
    test "date is in the future" do
      assert {:error, "DOB cannot be in the future"} = AgeGuard.is_old_enough?(1, 12, 3000, 21)
    end

    test "year is not a number" do
      assert {:error, "invalid format"} = AgeGuard.is_old_enough?(1, 12, "YYYY", 21)
    end

    test "month is not a number" do
      assert {:error, "invalid format"} = AgeGuard.is_old_enough?(1, "MM", 1995, 21)
    end

    test "day is not a number" do
      assert {:error, "invalid format"} = AgeGuard.is_old_enough?("DD", 12, 1995, 21)
    end
  end

  describe "when age is incorrect," do
    test "min_age is a negative number" do
      assert {:error, "min_age must be a positive integer"} =
               AgeGuard.is_old_enough?(1, 12, 1995, -10)
    end

    test "min_age is a float number" do
      assert {:error, "min_age must be a positive integer"} =
               AgeGuard.is_old_enough?(1, 12, 1995, 21.0)
    end

    test "min_age is not a number" do
      assert {:error, "min_age must be a positive integer"} =
               AgeGuard.is_old_enough?(1, 12, 1995, "age")
    end
  end
end

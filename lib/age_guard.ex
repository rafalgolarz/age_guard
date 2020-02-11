defmodule AgeGuard do
  @moduledoc """
  Verifies if a person born at a given date meets provided age requirements.
  It checks given DOB (date of birth) against given age.
  Useful when registering users.

  Acceptable formats of DOB (mix of integers and strings):

  ```
    1, 12, 2020
    01, 03, 2010
    "01", "12", "2020"
    "1", "3", "2010"
    "03", "March", "2011"
    "17", "Mar", "2018"
    17, "Mar", 2019
    "13", 02, "2019"
  ```

  Also does some dates validations (dates from the future are rejected).


  ## Installation

  The package can be installed by adding `age_guard` to your list of dependencies in `mix.exs`:

  ```elixir
  def deps do
  [
    {:age_guard, "~> 0.1.0"}
  ]
  end
  ```

  and running `mix deps.get` in your console to fetch from Hex.
  """

  @doc """
  Checks if enough years (min_age) have passed since given date.

  ```
  AgeGuard.is_old_enough?(day_of_birth, month_of_birth, year_of_birth, required_age)
  ```

  ### Examples

  ```
  iex> AgeGuard.is_old_enough?("1","5","2019", 21)
  false

  iex> AgeGuard.is_old_enough?(3, "March", 2000, 21)
  false

  iex> AgeGuard.is_old_enough?(3, 3, 2000, 18)
  true

  iex> AgeGuard.is_old_enough?(3, "Dec", 1995, 18)
  true
  ```

  """
  def is_old_enough?(day, month, year, min_age \\ 18) do
    if is_integer(min_age) && min_age > 0 do
      with {:ok, dob} <- verify_date(day, month, year) do
        meets_req_age?(dob, min_age)
      end
    else
      {:error, "min_age must be a positive integer"}
    end
  end

  # makes the actual calculations
  defp meets_req_age?(dob, min_req_age) do
    today = Date.utc_today()
    iso_day = format_to_iso(today.day)
    iso_month = format_to_iso(today.month)

    case Date.from_iso8601("#{to_string(today.year - min_req_age)}-#{iso_month}-#{iso_day}") do
      {:ok, today_minus_min_req_age} ->
        days_between_today_and_dob = Enum.count(Date.range(today, dob))
        days_between_today_and_req_yrs = Enum.count(Date.range(today, today_minus_min_req_age))

        days_between_today_and_dob >= days_between_today_and_req_yrs

      _ ->
        false
    end
  end

  # verifies if day, date, month make sense
  defp verify_date(day, month, year) do
    # ensure date meets acceptable ISO format
    iso_day = format_to_iso(day)
    iso_month = format_to_iso(month)
    iso_year = to_string(year)

    today = Date.utc_today()

    case Date.from_iso8601("#{iso_year}-#{iso_month}-#{iso_day}") do
      {:ok, iso_dob} ->
        if Date.diff(today, iso_dob) < 0 do
          {:error, "DOB cannot be in the future"}
        else
          {:ok, iso_dob}
        end

      _ ->
        {:error, "invalid format"}
    end
  end

  # ISO format requires day and month to be two digits
  defp format_to_iso(val) do
    cond do
      is_integer(val) and val < 10 ->
        "0" <> to_string(val)

      is_binary(val) and String.length(val) > 2 ->
        month_to_iso(String.downcase(val))

      is_binary(val) and String.length(val) == 1 ->
        "0" <> val

      true ->
        to_string(val)
    end
  end

  defp month_to_iso(month) when month in ["january", "jan"], do: "01"
  defp month_to_iso(month) when month in ["february", "feb"], do: "02"
  defp month_to_iso(month) when month in ["march", "mar"], do: "03"
  defp month_to_iso(month) when month in ["april", "apr"], do: "04"
  defp month_to_iso(month) when month in ["may", "may"], do: "05"
  defp month_to_iso(month) when month in ["june", "jun"], do: "06"
  defp month_to_iso(month) when month in ["july", "jul"], do: "07"
  defp month_to_iso(month) when month in ["august", "aug"], do: "08"
  defp month_to_iso(month) when month in ["september", "sept", "sep"], do: "09"
  defp month_to_iso(month) when month in ["october", "oct"], do: "10"
  defp month_to_iso(month) when month in ["november", "nov"], do: "11"
  defp month_to_iso(month) when month in ["december", "dec"], do: "12"
  defp month_to_iso(_), do: "incorrect"
end

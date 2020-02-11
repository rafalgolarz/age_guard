# AgeGuard

Verifies if a person born at a given date meets provided age requirements.

It checks given DOB (date of birth) against given age.
Useful when registering users.

Acceptable formats of DOB (mix of integers and strings):

```Elixir
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

## Basic Usage

```Elixir
AgeGuard.is_old_enough?(day_of_birth, month_of_birth, year_of_birth, required_age)
```

Examples:

```Elixir
  iex> AgeGuard.is_old_enough?("1","5","2019", 21)
  false

  iex> AgeGuard.is_old_enough?(3, "March", 2000, 21)
  false

  iex> AgeGuard.is_old_enough?(3, 3, 2000, 18)
  true

  iex> AgeGuard.is_old_enough?(3, "Dec", 1995, 18)
  true
```


## Author
Rafał Golarz

AgeGuard is released under the [MIT License](https://github.com/rafalgolarz/age_guard/blob/master/LICENSE.txt).
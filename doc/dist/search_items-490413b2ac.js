searchNodes=[{"doc":"Verifies if a person born at a given date meets provided age requirements. It checks given DOB (date of birth) against given age. Useful when registering users. Acceptable formats of DOB (mix of integers and strings): 1, 12, 2020 01, 03, 2010 &quot;01&quot;, &quot;12&quot;, &quot;2020&quot; &quot;1&quot;, &quot;3&quot;, &quot;2010&quot; &quot;03&quot;, &quot;March&quot;, &quot;2011&quot; &quot;17&quot;, &quot;Mar&quot;, &quot;2018&quot; 17, &quot;Mar&quot;, 2019 &quot;13&quot;, 02, &quot;2019&quot; Also does some dates validations (dates from the future are rejected). Installation The package can be installed by adding age_guard to your list of dependencies in mix.exs: def deps do [ {:age_guard, &quot;~&gt; 0.1.0&quot;} ] end and running mix deps.get in your console to fetch from Hex.","ref":"AgeGuard.html","title":"AgeGuard","type":"module"},{"doc":"Checks if enough years (min_age) have passed since given date. AgeGuard.is_old_enough?(day_of_birth, month_of_birth, year_of_birth, required_age) Examples iex&gt; AgeGuard.is_old_enough?(&quot;1&quot;,&quot;5&quot;,&quot;2019&quot;, 21) false iex&gt; AgeGuard.is_old_enough?(3, &quot;March&quot;, 2000, 21) false iex&gt; AgeGuard.is_old_enough?(3, 3, 2000, 18) true iex&gt; AgeGuard.is_old_enough?(3, &quot;Dec&quot;, 1995, 18) true","ref":"AgeGuard.html#is_old_enough?/4","title":"AgeGuard.is_old_enough?/4","type":"function"}]
defmodule MaMath do
  @moduledoc """
  These select functions specifically emphasize Elixir's pipeline operator |>, Enum functions, and function composition.
  """
  @spec debug(any, String.t()) :: any
  defp debug(data, msg) do
    IO.puts("#{msg}: #{inspect(data)}")
    data
  end

  @doc """
  even_sum takes a list of numbers, filters out odds, doubles each number, and returns their sum
  """
  @spec even_sum([integer]) :: integer
  def even_sum(list) do
    list
    |> debug("Original List: ")
    |> Enum.filter(fn x -> rem(x, 2) === 0 end)
    |> debug("After Filter: ")
    |> Enum.map(fn x -> x * 2 end)
    |> debug("After Doubling")
    |> Enum.sum()
    |> debug("Total Sum: ")
  end

  @doc """
  count_wordfreq takes a sentence and returns a map of word frequencies, using pipes and Enum functions
  """
  @spec count_wordfreq(String.t()) :: map
  def count_wordfreq(sentence) do
    sentence
    |> String.downcase()
    |> debug("After converting to lowercase: ")
    |> String.replace(~r/[^\w\s]/, "")
    |> debug("After replacing punctuations: ")
    |> String.split()
    |> debug("After Splitting: ")
    |> Enum.reduce(%{}, fn word, acc -> Map.update(acc, word, 1, &(&1 + 1)) end)
  end

  @doc """
  ris_prime eturns if a input is a prime number or not
  """
  @spec is_prime(integer()) :: boolean()
  def is_prime(1), do: false
  def is_prime(2), do: true

  def is_prime(num) when rem(num, 2) == 0 do
    false
  end

  def is_prime(num) do
    new_max = :math.sqrt(num) |> trunc()
    Enum.all?(3..new_max, fn x -> rem(num, x) != 0 end)
  end

  @doc """
  keep_prime_desc takes a range of numbers (1..n), keeps only prime numbers, and returns them in descending order.

  ## Examples

    iex> prime_pipeline(10)
    [7, 5, 3, 2]

    iex> prime_pipeline(20)
    [19, 17, 13, 11, 7, 5, 3, 2]
  """
  @spec keep_prime_desc(pos_integer()) :: [pos_integer()]
  def keep_prime_desc(n) do
    1..n
    |> Enum.filter(fn x -> is_prime(x) end)
    |> Enum.sort(:desc)
  end

  @doc """
  cel_to_fah transforms a list of temperatures in Celsius to Fahrenheit using pipes and Enum.map
  """
  @spec cel_to_fah([integer()]) :: [integer()]
  def cel_to_fah(list) do
    list
    |> Enum.map(fn x -> {x, x * (9 / 5) + 32} end)
    |> Map.new()
  end

  @doc """
  remove_small_words takes a list of strings, converts each to uppercase, filters out short words (<4 chars), and joins them with commas
  """
  @spec remove_small_words([String.t()]) :: [String.t()]
  def remove_small_words(strs) do
    strs
    |> Enum.map(fn x -> String.upcase(x) end)
    |> Enum.filter(fn x -> String.length(x) > 4 end)
    |> Enum.join(", ")
  end
end

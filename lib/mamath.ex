defmodule MaMath do
  @moduledoc """
  These select functions specifically emphasize Elixir's pipeline operator |>, Enum functions, and function composition.
  Each problem will build upon the previous ones to reinforce these concepts.
  """
  @spec debug(any, String.t()) :: any
  defp debug(list, msg) do
    IO.puts("#{msg}: #{inspect(list)}")
    list
  end

  @doc """
  Create a pipeline that takes a list of numbers, filters out odds, doubles each number, and returns their sum
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
  function that takes a sentence and returns a map of word frequencies, using pipes and Enum functions
  """
  @spec count_wordfreq(String.t()) :: map
  def count_wordfreq(_str) do
  end
end

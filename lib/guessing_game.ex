defmodule GuessingGame do
  # guess between the low and high number.
  # program guesses a number
  # if yes -> "game over"
  # if guess is bigger -> guess a smaller number (low - current_guess)
  # if guess is smaller -> guess a bigger number from (current_guess - high)

  def guess(a, b) when a > b, do: guess(b, a)

  def guess(low, high) do
    answer = IO.gets("Hey, you thinking of #{mid(low, high)}?\n")

    case String.trim(answer) do
      "bigger" ->
        guess_big(low, high)

      "smaller" ->
        guess_small(low, high)

      "yes" ->
        "Haha, Got You."

      _ ->
        IO.puts(~s{Type "bigger", "smaller" or "yes"})
        guess(low, high)
    end
  end

  def mid(low, high) do
    div(low + high, 2)
  end

  def guess_big(low, high) do
    new_low = min(high, mid(low, high) + 1)
    guess(new_low, high)
  end

  def guess_small(low, high) do
    new_high = max(low, mid(low, high) - 1)
    guess(low, new_high)
  end
end

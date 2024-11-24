defmodule TheGreeter do
  # this program greets a user, with their name
  # when user enters their name: greet with "Hello, there #{user}, nice to meet you."
  # if the user's name is the creator of this program then greet: "Heey, its my favourite person, #{user}. Nice seeing you again my creator"

  def greet do
    name = IO.gets("Hey whats your name? ")

    case String.trim(name) do
      "andy" ->
        IO.puts(~s{Heey, its my favourite person, andy. Nice seeing you again my creator})

      name ->
        IO.puts(~s{Hello, there #{name}, nice to meet you.})
    end
  end
end

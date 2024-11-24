defmodule Todo do
  def ask_file() do
    IO.puts("Enter filename:")
    IO.gets("> ") |> String.trim()
  end

  def read_file(file) do
    case File.read(file) do
      {:ok, content} -> content
      {:error, reason} -> "Error opening file #{file}. The raw error msg: #{reason}"
    end
  end

  def parse_content(content) do
    content
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, ","))
    |> List.delete_at(0)
  end

  def get_commands() do
    IO.puts(
      "Todo Commands:\n#1.Show All\t#2.Create\t#3.Delete\t#4.Mark Complete\t#5.Save\t#6.Quit\n"
    )

    command = IO.gets("-> $: ")
    String.trim(command)
  end

  def print_task(task) do
    {desc, status, date} = task
    IO.puts(~s{Date -> ~~#{date}~~ | Task -> ~~#{desc}~~ | Status -> ~~#{status}~~})
  end

  def start() do
    # ask user for filename
    # open file and read
    # parse the data
    # ask command from user.
    # (#1. read, #2. create, #3. delete, #4. update, #5. save, #6. quit)

    file = ask_file()
    raw_content = read_file(file)

    if String.contains?(raw_content, "Error") do
      IO.puts(raw_content)
      start()
    end

    parsed_content = parse_content(raw_content)
    command = get_commands()

    case command do
      "1" ->
        Enum.each(parsed_content, fn x ->
          print_task({Enum.at(x, 2), Enum.at(x, 0), Enum.at(x, 1)})
        end)

        start()

      "2" ->
        IO.puts("Created a todo\n")
        d = String.trim(IO.gets("Enter Description: \n>"))
        s = String.trim(IO.gets("Enter Status (true/false): \n>"))
        da = String.trim(IO.gets("Enter date (YYYY-MM-DD)"))
        task = %{d => {d, s, da}}
        {desc, status, date} = task[d]

        print_task({desc, status, date})
        # TODO: upload the task to the csv file
        start()

      "3" ->
        IO.puts("Todo deleted.\n")
        start()

      "4" ->
        IO.puts("Marked todo as done.\n")
        start()

      "5" ->
        IO.puts("New changes saved to file.\n")
        start()

      "6" ->
        IO.puts("Program Exitted.\n")
        start()

      _ ->
        start()
        IO.puts("Invalid Command.\n")
    end
  end
end

defmodule Todo do
  def ask_file() do
    IO.puts("")
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
    IO.puts("Todo Commands:\n#1.Show All\t#2.Create\t#3.Delete\t#4.Quit\n")

    command = IO.gets("-> $: ")
    String.trim(command)
  end

  def format_task(task) do
    [desc, status, date] = task
    ~s{Date -> ~~#{date}~~ | Task -> ~~#{desc}~~ | Status -> ~~#{status}~~}
  end

  def input_prompt(question) do
    IO.gets("#{question} \n> ") |> String.trim()
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
          x |> format_task() |> IO.puts()
        end)

        start()

      "2" ->
        d = input_prompt("Enter Description: ")
        s = input_prompt("Enter Status (true/false): ")
        da = input_prompt("Enter date (YYYY-MM-DD): ")
        _task = %{d => {d, s, da}}

        case File.write("todo.csv", "#{d}, #{s}, #{da}\n", [:append]) do
          :ok -> IO.puts("Successfully added todo")
          {:error, reason} -> IO.puts("Failed to add todo: #{reason}")
        end

        IO.puts("Created a todo\n")
        start()

      "3" ->
        task_name = input_prompt("Enter the task name to delete: ")

        File.stream!("todo.csv")
        |> Stream.reject(fn line ->
          String.split(line, ",")
          |> Enum.at(0)
          |> String.contains?(task_name)
        end)
        |> Stream.into(File.stream!("todo_tmp.csv"))
        |> Stream.run()

        File.rename!("todo_tmp.csv", "todo.csv")

        IO.puts("Todo deleted.\n")
        start()

      "4" ->
        IO.puts("Program Exitted.\n")

      _ ->
        start()
        IO.puts("Invalid Command.\n")
    end
  end
end

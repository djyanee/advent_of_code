defmodule InputReader do
  def read do
    File.read!("2019/day02/input.txt")
    |> String.split([",", "\n"], trim: true)
    |> Enum.map(&String.to_integer(&1))
  end
end

defmodule PartOne do
  def run(noun, verb) do
    InputReader.read
    |> List.replace_at(1, noun)
    |> List.replace_at(2, verb)
    |> calculate(0)
  end

  defp calculate(input, current_position) do
    opcode = Enum.at(input, current_position)
    first_position = Enum.at(input, current_position + 1)
    second_position = Enum.at(input, current_position + 2)

    { status, new_value } = case opcode do
      1 -> { :ok, Enum.at(input, first_position) + Enum.at(input, second_position) }
      2 -> { :ok, Enum.at(input, first_position) * Enum.at(input, second_position) }
      _ -> { :halt, nil }
    end

    if status == :ok do
      target_position = Enum.at(input, current_position + 3)

      List.replace_at(input, target_position, new_value)
      |> calculate(current_position + 4)
    else
      List.first(input)
    end
  end
end

defmodule PartTwo do
  def run(noun, verb) do
    output = PartOne.run(noun, verb)

    cond do
      output == 19690720 -> 100 * noun + verb
      noun == 99 -> run(0, verb + 1)
      true -> run(noun + 1, verb)
    end
  end
end

PartOne.run(12, 2) |> IO.inspect
PartTwo.run(0, 0) |> IO.inspect

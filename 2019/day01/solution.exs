defmodule InputReader do
  def read do
    File.read!("2019/day01/input.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer(&1))
  end
end

defmodule PartOne do
  def run do
    InputReader.read
    |> Enum.map(&calculate_mass(&1))
    |> Enum.sum
  end

  defp calculate_mass(value) do
    floor(value / 3) - 2
  end
end

defmodule PartTwo do
  def run do
    InputReader.read
    |> Enum.map(&calculate_mass(&1, 0))
    |> Enum.sum
  end

  defp calculate_mass(value, mass) do
    result = floor(value / 3) - 2

    if result <= 0 do
      mass
    else
      calculate_mass(result, mass + result)
    end
  end
end

PartOne.run |> IO.puts
PartTwo.run |> IO.puts

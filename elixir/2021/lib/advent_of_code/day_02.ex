defmodule AdventOfCode.Day02 do
  def part1(args) do
    [final_depth, final_horizontal] =
      args
      |> Enum.map(fn s -> String.split(s, " ") end)
      |> Enum.map(fn [cmd, val] -> [cmd, String.to_integer(val)] end)
      |> Enum.reduce([0, 0], fn [cmd, val], [depth, horizontal] ->
        case cmd do
          "forward" -> [depth, horizontal + val]
          "up" -> [depth - val, horizontal]
          "down" -> [depth + val, horizontal]
        end
      end)

    final_depth * final_horizontal
  end

  def part2(args) do
  end
end

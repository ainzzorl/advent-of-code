defmodule Mix.Tasks.D01.P2 do
  use Mix.Task

  import AdventOfCode.Day01

  @shortdoc "Day 01 Part 2"
  def run(args) do
    {:ok, contents} = File.read("../inputs/day01")
    lines = contents |> String.split("\n", trim: true)
    input = Enum.map(lines, fn s -> Integer.parse(s) |> elem(0) end)

    if Enum.member?(args, "-b"),
      do: Benchee.run(%{part_2: fn -> input |> part2() end}),
      else:
        input
        |> part2()
        |> IO.inspect(label: "Part 2 Results")
  end
end

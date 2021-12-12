defmodule Mix.Tasks.D01.P1 do
  use Mix.Task

  import AdventOfCode.Day01

  @shortdoc "Day 01 Part 1"
  def run(args) do
    {:ok, contents} = File.read("../inputs/day01")
    lines = contents |> String.split("\n", trim: true)
    input = Enum.map(lines, fn s -> Integer.parse(s) |> elem(0) end)

    if Enum.member?(args, "-b"),
      do: Benchee.run(%{part_1: fn -> input |> part1() end}),
      else:
        input
        |> part1()
        |> IO.inspect(label: "Part 1 Results")
  end
end

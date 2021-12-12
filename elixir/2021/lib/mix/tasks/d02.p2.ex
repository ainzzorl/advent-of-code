defmodule Mix.Tasks.D02.P2 do
  use Mix.Task

  import AdventOfCode.Day02

  @shortdoc "Day 02 Part 2"
  def run(args) do
    {:ok, contents} = File.read("../../ruby/2021/inputs/day02")
    input = contents |> String.split("\n", trim: true)

    if Enum.member?(args, "-b"),
      do: Benchee.run(%{part_2: fn -> input |> part2() end}),
      else:
        input
        |> part2()
        |> IO.inspect(label: "Part 2 Results")
  end
end

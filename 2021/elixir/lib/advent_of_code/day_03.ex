defmodule AdventOfCode.Day03 do
  def part1(args) do
    nbits = List.first(args) |> String.length()
    initial_counts = List.duplicate(0, nbits)

    counts =
      args
      |> Enum.reduce(initial_counts, &AdventOfCode.Day03.update_counts/2)

    gamma =
      counts |> Enum.map(fn c -> if c > length(args) / 2, do: 1, else: 0 end) |> arr_to_int()

    eps = counts |> Enum.map(fn c -> if c < length(args) / 2, do: 1, else: 0 end) |> arr_to_int()

    gamma * eps
  end

  def update_counts(s, counts) do
    counts
    |> Enum.with_index()
    |> Enum.map(fn {c, i} -> if String.at(s, i) == "1", do: c + 1, else: c end)
  end

  def arr_to_int(a) do
    a |> Enum.reduce(0, fn c, acc -> c + acc * 2 end)
  end

  def str_to_int_list(a) do
    a |> String.graphemes() |> Enum.map(fn c -> if c == "1", do: 1, else: 0 end)
  end

  def part2(args) do
    args_as_lists = args |> Enum.map(fn a -> a |> str_to_int_list end)
    oxygen = get_bit_criteria_match(args_as_lists, 0, true) |> arr_to_int()
    co2 = get_bit_criteria_match(args_as_lists, 0, false) |> arr_to_int()

    oxygen * co2
  end

  def get_bit_criteria_match(a, i, pickpopular) do
    if length(a) == 1 do
      a |> List.first()
    else
      count_ones =
        a |> Enum.reduce(0, fn e, count -> if Enum.at(e, i) == 1, do: count + 1, else: count end)

      choice =
        if pickpopular do
          if count_ones >= length(a) / 2, do: 1, else: 0
        else
          if count_ones < length(a) / 2, do: 1, else: 0
        end

      a
      |> Enum.filter(fn s -> Enum.at(s, i) == choice end)
      |> get_bit_criteria_match(i + 1, pickpopular)
    end
  end
end

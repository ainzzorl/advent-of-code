defmodule AdventOfCode.Day04 do
  def part1(args) do
    called_str =
      args
      |> Enum.at(0)

    called =
      String.split(called_str, ",")
      |> Enum.map(fn n -> String.to_integer(n) end)

    bingo_boards_cnt = div(length(args) - 1, 6)

    range = 0..(bingo_boards_cnt - 1)

    boards = Enum.map(range, fn i -> get_board(args, i) end)

    solved =
      boards
      |> Enum.map(fn board -> solve(board, called) end)

    [score, _] = solved |> Enum.min_by(fn [_s, i] -> i end)
    score
  end

  defp get_board(args, i) do
    [
      args |> Enum.at(2 + i * 6) |> to_int_list,
      args |> Enum.at(3 + i * 6) |> to_int_list,
      args |> Enum.at(4 + i * 6) |> to_int_list,
      args |> Enum.at(5 + i * 6) |> to_int_list,
      args |> Enum.at(6 + i * 6) |> to_int_list
    ]
  end

  defp to_int_list(s) do
    String.split(s, " ")
    |> Enum.map(fn s -> String.trim(s) end)
    |> Enum.filter(fn s -> s != "" end)
    |> Enum.map(fn n -> String.to_integer(n) end)
  end

  defp solve(board, called) do
    used_init = List.duplicate(List.duplicate(false, 5), 5)

    [_u, score, found_index] =
      called
      |> Enum.with_index()
      |> Enum.reduce([used_init, 0, length(called) + 1], fn {move, index},
                                                            [used, found_score, found_index] ->
        if found_index < index do
          [used, found_score, found_index]
        else
          new_used = apply_move(used, board, move)

          if bingo?(new_used) do
            [new_used, get_score(board, new_used, move), index]
          else
            [new_used, found_score, found_index]
          end
        end
      end)

    [score, found_index]
  end

  defp get_score(board, used, just_called) do
    uncalled =
      Enum.zip(used, board)
      |> Enum.map(fn {ru, rb} ->
        Enum.zip(ru, rb)
        |> Enum.reduce(0, fn {u, b}, s ->
          if u do
            s
          else
            s + b
          end
        end)
      end)
      |> Enum.sum()

    uncalled * just_called
  end

  defp apply_move(used, board, move) do
    Enum.zip(used, board)
    |> Enum.map(fn {ru, rb} ->
      Enum.zip(ru, rb)
      |> Enum.map(fn {u, b} ->
        u || b == move
      end)
    end)
  end

  defp bingo?(used) do
    0..4
    |> Enum.any?(fn i ->
      row = used |> Enum.at(i)
      col = used |> Enum.map(fn r -> r |> Enum.at(i) end)

      Enum.all?(row) || Enum.all?(col)
    end)
  end

  def part2(_args) do
  end
end

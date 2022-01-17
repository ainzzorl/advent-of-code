defmodule AdventOfCode.Day05 do
  defmodule Point do
    defstruct [:x, :y]
  end

  defmodule Line do
    defstruct [:x1, :y1, :x2, :y2]

    alias __MODULE__

    def parse(s) do
      [p1, p2] = String.split(s, " -> ")
      [x1s, y1s] = String.split(p1, ",")
      x1 = String.to_integer(x1s)
      y1 = String.to_integer(y1s)
      [x2s, y2s] = String.split(p2, ",")
      x2 = String.to_integer(x2s)
      y2 = String.to_integer(y2s)

      if x1 == x2 do
        %Line{x1: x1, y1: min(y1, y2), x2: x2, y2: max(y1, y2)}
      else
        if y1 == y2 do
          %Line{x1: min(x1, x2), y1: y1, x2: max(x1, x2), y2: y2}
        else
          if x1 < x2 do
            %Line{x1: x1, y1: y1, x2: x2, y2: y2}
          else
            %Line{x1: x2, y1: y2, x2: x1, y2: y1}
          end
        end
      end
    end

    def vertical?(l) do
      l.x1 == l.x2
    end

    def horizontal?(l) do
      l.y1 == l.y2
    end

    def diagonal?(l) do
      l.x1 != l.x2 && l.y1 != l.y2
    end

    @spec up?(atom | %{:y1 => any, :y2 => any, optional(any) => any}) :: boolean
    def up?(l) do
      l.y1 < l.y2
    end

    def down?(l) do
      l.y1 < l.y2
    end

    def diagy(d, x) do
      s = slope(d)
      dx = x - d.x1
      d.y1 + dx * s
    end

    def diagx(d, y) do
      s = slope(d)
      dy = y - d.y1
      d.x1 + dy * s
    end

    def slope(d) do
      if d.y1 < d.y2 do
        1
      else
        -1
      end
    end

    def get_vertical_overlaps(l1, l2) do
      if l1.x1 == l2.x1 do
        start = max(l1.y1, l2.y1)
        fin = min(l1.y2, l2.y2)

        if start <= fin do
          start..fin |> Enum.map(fn y -> %Point{x: l1.x1, y: y} end)
        else
          []
        end
      else
        []
      end
    end

    def get_horizonlal_overlaps(l1, l2) do
      if l1.y1 == l2.y1 do
        start = max(l1.x1, l2.x1)
        fin = min(l1.x2, l2.x2)

        if start <= fin do
          start..fin |> Enum.map(fn x -> %Point{x: x, y: l1.y1} end)
        else
          []
        end
      else
        []
      end
    end

    def get_vertical_and_horizontal_overlaps(v, h) do
      if h.y1 >= v.y1 && h.y1 <= v.y2 && v.x1 >= h.x1 && v.x1 <= h.x2 do
        [%Point{x: v.x1, y: h.y1}]
      else
        []
      end
    end

    def get_diagonal_overlaps(l1, l2) do
      if(slope(l1) != slope(l2)) do
        [up, down] =
          if up?(l1) do
            [l1, l2]
          else
            [l2, l1]
          end

        dy = diagy(down, 0) - diagy(up, 0)

        if rem(dy, 2) != 0 do
          []
        else
          y = div(diagy(down, 0) + diagy(up, 0), 2)
          x = diagx(up, y)

          in_up = x >= up.x1 && x <= up.x2 && y >= up.y1 && y <= up.y2
          in_down = x >= down.x1 && x <= down.x2 && y >= down.y2 && y <= down.y1

          if in_up && in_down do
            [%Point{x: x, y: y}]
          else
            []
          end
        end
      else
        # Same slope
        if diagy(l1, 0) != diagy(l2, 0) do
          []
        else
          start = max(l1.x1, l2.x1)
          fin = min(l1.x2, l2.x2)

          if start <= fin do
            start..fin |> Enum.map(fn x -> %Point{x: x, y: diagy(l1, x)} end)
          else
            []
          end
        end
      end
    end

    def get_vertical_and_diagonal_overlaps(v, d) do
      cond do
        v.x1 < d.x1 || v.x1 > d.x2 ->
          []

        true ->
          y = diagy(d, v.x1)

          if y >= v.y1 && y <= v.y2 do
            [%Point{x: v.x1, y: y}]
          else
            []
          end
      end
    end

    def get_horizontal_and_diagonal_overlaps(h, d) do
      cond do
        h.y1 < min(d.y1, d.y2) || h.y1 > max(d.y1, d.y2) ->
          []

        true ->
          x = diagx(d, h.y1)

          if x >= h.x1 && x <= h.x2 do
            [%Point{x: x, y: h.y1}]
          else
            []
          end
      end
    end

    def get_overlaps(l1, l2) do
      cond do
        vertical?(l1) && vertical?(l2) ->
          get_vertical_overlaps(l1, l2)

        horizontal?(l1) && horizontal?(l2) ->
          get_horizonlal_overlaps(l1, l2)

        (vertical?(l1) && horizontal?(l2)) || (vertical?(l2) && horizontal?(l1)) ->
          [v, h] =
            if vertical?(l1) && horizontal?(l2) do
              [l1, l2]
            else
              [l2, l1]
            end

          get_vertical_and_horizontal_overlaps(v, h)

        (vertical?(l1) && diagonal?(l2)) || (vertical?(l2) && diagonal?(l1)) ->
          [v, d] =
            if vertical?(l1) && diagonal?(l2) do
              [l1, l2]
            else
              [l2, l1]
            end

          get_vertical_and_diagonal_overlaps(v, d)

        (horizontal?(l1) && diagonal?(l2)) || (horizontal?(l2) && diagonal?(l1)) ->
          [h, d] =
            if horizontal?(l1) && diagonal?(l2) do
              [l1, l2]
            else
              [l2, l1]
            end

          get_horizontal_and_diagonal_overlaps(h, d)

        diagonal?(l1) && diagonal?(l2) ->
          get_diagonal_overlaps(l1, l2)
      end
    end
  end

  def part1(args) do
    lines =
      args
      |> Enum.map(fn s -> Line.parse(s) end)
      |> Enum.filter(fn l -> Line.vertical?(l) || Line.horizontal?(l) end)

    all_overlap_lists = for l1 <- lines, l2 <- lines, l1 != l2, do: Line.get_overlaps(l1, l2)

    all_overlaps = all_overlap_lists |> List.flatten()
    res = all_overlaps |> Enum.uniq()
    length(res)
  end

  def part2(args) do
    lines =
      args
      |> Enum.map(fn s -> Line.parse(s) end)

    all_overlap_lists = for l1 <- lines, l2 <- lines, l1 != l2, do: Line.get_overlaps(l1, l2)

    all_overlaps = all_overlap_lists |> List.flatten()
    res = all_overlaps |> Enum.uniq()
    length(res)
  end
end

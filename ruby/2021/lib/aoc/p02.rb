module AOC
  def self.p02_1(vals)
    horizontal, depth =
      vals
      .reduce([0, 0]) do |pos, line|
        command, v = line.split(' ')
        v = Integer(v)
        case command
        when 'forward'
          [pos[0] + v, pos[1]]
        when 'up'
          [pos[0], pos[1] - v]
        when 'down'
          [pos[0], pos[1] + v]
        end
      end
    horizontal * depth
  end

  def self.p02_2(vals)
    horizontal, depth, =
      vals
      .reduce([0, 0, 0]) do |pos, line|
        h, d, a = *pos
        command, v = line.split(' ')
        v = Integer(v)
        case command
        when 'forward'
          [h + v, d + v * a, a]
        when 'up'
          [h, d, a - v]
        when 'down'
          [h, d, a + v]
        end
      end
    horizontal * depth
  end
end

module AOC
  def self.p01_1(vals)
    (1...vals.size)
      .select { |i| vals[i] > vals[i - 1] }
      .size
  end

  def self.p01_2(vals)
    triplets = (1...vals.size - 1)
               .map { |i| vals[i - 1] + vals[i] + vals[i + 1] }
    p01_1(triplets)
  end
end

module AOC
  def self.p01(vals)
    (1...vals.size)
      .select { |i| vals[i] > vals[i - 1] }
      .size
  end
end

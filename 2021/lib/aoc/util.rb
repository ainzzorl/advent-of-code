module AOC
  def self.read_ints_from_file(path)
    File.readlines(path).map { |l| Integer(l) }
  end
end

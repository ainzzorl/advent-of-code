RSpec.describe 'p01' do
  describe 'part 1' do
    it 'solves the example' do
      expect(AOC.p01_1([199, 200, 208, 210, 200, 207, 240, 269, 260, 263])).to eq 7
    end

    it 'solves the real input' do
      input = AOC.read_ints_from_file('../inputs/day01')
      expect(AOC.p01_1(input)).to eq 1559
    end
  end

  describe 'part 2' do
    it 'solves the example' do
      expect(AOC.p01_2([199, 200, 208, 210, 200, 207, 240, 269, 260, 263])).to eq 5
    end

    it 'solves the real input' do
      input = AOC.read_ints_from_file('../inputs/day01')
      expect(AOC.p01_2(input)).to eq 1600
    end
  end
end

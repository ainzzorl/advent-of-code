RSpec.describe 'p02' do
  describe 'part 1' do
    it 'solves the example' do
      expect(AOC.p02_1([
                         'forward 5',
                         'down 5',
                         'forward 8',
                         'up 3',
                         'down 8',
                         'forward 2'
                       ])).to eq 150
    end

    it 'solves the real input' do
      input = AOC.read_strings_from_file('../inputs/day02')
      expect(AOC.p02_1(input)).to eq 1_962_940
    end
  end

  describe 'part 2' do
    it 'solves the example' do
      expect(AOC.p02_2([
                         'forward 5',
                         'down 5',
                         'forward 8',
                         'up 3',
                         'down 8',
                         'forward 2'
                       ])).to eq 900
    end

    it 'solves the real input' do
      input = AOC.read_strings_from_file('../inputs/day02')
      expect(AOC.p02_2(input)).to eq 1_813_664_422
    end
  end
end

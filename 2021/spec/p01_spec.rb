RSpec.describe '#p01' do
  it 'solves the example' do
    expect(AOC.p01([199, 200, 208, 210, 200, 207, 240, 269, 260, 263])).to eq 7
  end

  it 'solves the real input' do
    input = AOC.read_ints_from_file('inputs/day01')
    expect(AOC.p01(input)).to eq 1559
  end
end

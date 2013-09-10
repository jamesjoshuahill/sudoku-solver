require 'cell'

describe Cell do
  let(:neighbours) { (1..28).to_a }
  let(:cell) { Cell.new(0, neighbours) }

  it 'should have a value' do
    expect(cell.value).to eq 0
    cell = Cell.new(1, neighbours)
    expect(cell.value).to eq 1
  end

  it 'should know it has been filled' do
    cell = Cell.new(5, neighbours)
    expect(cell).to be_filled_out
  end

  it 'should know if it has not been filled out' do
    expect(cell).not_to be_filled_out
  end

  it 'should have 28 neighbours' do
    expect(cell.neighbours).to be neighbours
    expect(cell.neighbours.count).to eq 28
  end

  it 'should know the values of it\'s neighbours' do
    neighbour = double :Cell, value: 1
    neighbours = [neighbour] * 28
    cell = Cell.new(0, neighbours)
    expect(cell.values_of_neighbours).to eq([1] * 28)

    neighbour = double :Cell, value: 5
    neighbours = [neighbour] * 28
    cell = Cell.new(0, neighbours)
    expect(cell.values_of_neighbours).to eq([5] * 28)
  end

  context 'when it has not been filled out' do
    it 'should know which values are possible' do
      expect(cell).to receive(:values_of_neighbours).and_return [1, 2, 3, 4]
      expect(cell.possible_values).to eq [5, 6, 7, 8, 9]

      expect(cell).to receive(:values_of_neighbours).and_return [5, 6, 7, 8, 9]
      expect(cell.possible_values).to eq [1, 2, 3, 4]
    end

    it 'should solve itself if there is only one possible value' do
      expect(cell).to receive(:possible_values).twice.and_return [5]
      cell.solve
      expect(cell.value).to eq 5

      expect(cell).to receive(:possible_values).twice.and_return [3]
      cell.solve
      expect(cell.value).to eq 3
    end

    it 'should not solve itself if there is more than one possible value' do
      expect(cell).to receive(:possible_values).and_return [1, 2, 3]
      cell.solve
      expect(cell).not_to be_filled_out
    end
  end
end
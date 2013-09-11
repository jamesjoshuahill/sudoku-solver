require 'cell'

describe Cell do
  let(:cell) { Cell.new(0) }

  it 'should have a value' do
    expect(cell.value).to eq 0
    cell = Cell.new(1)
    expect(cell.value).to eq 1
  end

  it 'should know it has been filled' do
    cell = Cell.new(5)
    expect(cell).to be_filled_out
  end

  it 'should know if it has not been filled out' do
    expect(cell).not_to be_filled_out
  end

  it 'should start with no neighbours' do
    cell = Cell.new(0)
    expect(cell.neighbours).to be_empty
  end

  context 'before all 28 neighbours have been added' do
    it 'should add neighbours' do
      neighbour = Cell.new(1)
      cell.add_neighbours([neighbour])
      expect(cell.neighbours).to include neighbour
    end

    it 'should not add more than 28 neighbours' do
      neighbour = Cell.new(1)
      other_neighbour = Cell.new(2)
      28.times { cell.add_neighbours([neighbour]) }
      cell.add_neighbours([other_neighbour])
      expect(cell.neighbours).not_to include other_neighbour
    end

    it 'should not know the value of it\'s neighbours' do
      expect(cell.values_of_neighbours).to be_nil
      cell.add_neighbours([Cell.new(2)])
      expect(cell.values_of_neighbours).to be_nil
    end
  end

  context 'when 28 neighbours have been added' do
    before(:each) do
      neighbour = Cell.new(1)
      neighbours = [neighbour] * 28
      cell.add_neighbours(neighbours)
    end

    it 'should have 28 neighbours' do
      expect(cell.neighbours.count).to eq 28
    end

    it 'should know the values of it\'s neighbours' do
      expect(cell.values_of_neighbours).to eq([1] * 28)

      neighbour = Cell.new(5)
      neighbours = [neighbour] * 28
      cell = Cell.new(0)
      cell.add_neighbours(neighbours)
      expect(cell.values_of_neighbours).to eq([5] * 28)
    end
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
require 'cell'

describe Cell do
  let(:neighbours) { (1..28).to_a }

  it 'should have a value' do
    cell = Cell.new(0, neighbours)
    expect(cell.value).to eq 0
    cell = Cell.new(1, neighbours)
    expect(cell.value).to eq 1
  end

  it 'should know it has been filled' do
    cell = Cell.new(5, neighbours)
    expect(cell).to be_filled_out
  end

  it 'should know if it has not been filled out' do
    cell = Cell.new(0, neighbours)
    expect(cell).not_to be_filled_out
  end

  it 'should have 28 neighbours' do
    cell = Cell.new(0, neighbours)
    expect(cell.neighbours).to be neighbours
    expect(cell.neighbours.count).to eq 28
  end
end
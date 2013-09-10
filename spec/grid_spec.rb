require 'grid'

describe Grid do
  let(:puzzle) { '015003002000100906270068430490002017501040380003905000900081040860070025037204600' }
  let(:grid) { Grid.new(puzzle) }

  it 'should have 81 cells' do
    expect(grid.cells.length).to eq 81
  end

  it 'should name each cell' do
    expect(grid.cells[:C1R1].value).to eq 0
    expect(grid.cells[:C3R1].value).to eq 5
  end

  it 'should know it has not been solved' do
    expect(grid).not_to be_solved
  end

  it 'should know if it has been solved' do
    grid = Grid.new('1' * 81)
    expect(grid).to be_solved
  end
end
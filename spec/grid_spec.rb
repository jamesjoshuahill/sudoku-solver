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

  xit 'should know which cells are in the same row of a puzzle' do
    expect(grid.row(1, puzzle)).to eq [0, 1, 5, 0, 0, 3, 0, 0, 2]
    expect(grid.row(2, puzzle)).to eq [0, 0, 0, 1, 0, 0, 9, 0, 6]
  end

  it 'should know it has not been solved' do
    expect(grid).not_to be_solved
  end

  it 'should know if it has been solved' do
    grid = Grid.new('1' * 81)
    expect(grid).to be_solved
  end
end
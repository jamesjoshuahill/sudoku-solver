require 'cell'

class Grid
  attr_reader :cells

  def initialize(puzzle)
    @cells = create_cells_from(puzzle)
  end

  def create_cells_from(puzzle)
    numbers = puzzle.chars.map(&:to_i)
    cells = []
    (0..8).each do |row|
      new_row = []
      (0..8).each do |column|
        new_row << Cell.new(numbers.shift)
      end
      cells << new_row
    end
    cells
  end

  def solved?
    @cells.flatten.map(&:filled_out?).all?
  end

  def make_neighbours_in_row(row)
    make_neighbours(@cells[row])
  end

  def make_neighbours_in_column(column)
    make_neighbours(@cells.transpose[column])
  end

  def make_neighbours_in_box(box)
    make_neighbours(members_of(box))
  end

  def make_neighbours(cells)
    cells.each do |cell|
      neighbours = cells - [cell]
      cell.add_neighbours(neighbours)
    end
  end

  def members_of(box)
    box_corners = [[0, 0], [1, 3], [2, 6], [3, 0], [3, 3], [3, 6], [6, 0], [6, 3], [6, 6]]
    row = box_corners[box][0]
    column = box_corners[box][1]
    [@cells[row][column, 3], @cells[row+1][column, 3], @cells[row+2][column, 3]].flatten
  end
end
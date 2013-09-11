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

  def cells_solved
    @cells.flatten.select(&:filled_out?).count
  end

  def solved?
    @cells.flatten.map(&:filled_out?).all?
  end

  def solve
    make_all_neighbours
    
    grid_changed_in_last_loop = true
    while !solved? && grid_changed_in_last_loop
      puts inspect
      puts "Solved? #{solved?}    :    Cells solved #{cells_solved}"
      grid_changed_in_last_loop = number_of_cells_changed { solve_2d(@cells) }
      puts "Solved? #{solved?}    :    Cells solved #{cells_solved}"
    end
  end

  def number_of_cells_changed
    cells_solved_before = cells_solved
    
    yield

    cells_solved_after = cells_solved
    cells_solved_before < cells_solved_after
  end

  def solve_2d(cells)
    # Ask every cell to solve itself
    cells.flatten.each { |cell| cell.solve }
  end

  def make_neighbours_in_row(row)
    make_cells_neighbours(@cells[row])
  end

  def make_neighbours_in_column(column)
    make_cells_neighbours(@cells.transpose[column])
  end

  def make_neighbours_in_box(box)
    make_cells_neighbours(members_of(box))
  end

  def make_cells_neighbours(cells)
    cells.each do |cell|
      neighbours = cells - [cell]
      cell.add_neighbours(neighbours)
    end
  end

  def make_all_neighbours
    (0..8).each do |x|
      make_neighbours_in_row(x)
      make_neighbours_in_column(x)
      make_neighbours_in_box(x)
    end
  end

  def members_of(box)
    box_corners = [[0, 0], [1, 3], [2, 6], [3, 0], [3, 3], [3, 6], [6, 0], [6, 3], [6, 6]]
    row = box_corners[box][0]
    column = box_corners[box][1]
    [@cells[row][column, 3], @cells[row+1][column, 3], @cells[row+2][column, 3]].flatten
  end

  def inspect
    grid_as_string = ('-' * 37) + "\n"
    @cells.each do |row|
      row_as_string = "|"
      row.each do |cell|
        row_as_string += " #{cell.value} |"
      end
      grid_as_string += row_as_string + "\n"
      grid_as_string += ('-' * 37) + "\n"
    end
    grid_as_string
  end
end
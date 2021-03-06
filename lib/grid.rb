require 'cell'

class Grid

  attr_reader :cells

  def initialize(puzzle)
    @cells = create_cells_from(puzzle)
  end

  def list_of_cells_from(string)
    numbers = string.chars.map(&:to_i)
    numbers.map! { |number| Cell.new(number) }
  end

  def create_cells_from(puzzle)
    cells = list_of_cells_from(puzzle)
    grid_from(cells)
  end

  def grid_from(cells)
    grid = []
    cells.each_slice(9) { |nine_cells| grid << nine_cells }
    grid
  end

  def cells_solved
    @cells.flatten.select(&:filled_out?)
  end

  def cells_not_solved
    @cells.flatten - @cells.flatten.select(&:filled_out?)
  end

  def solved?
    @cells.flatten.map(&:filled_out?).all?
  end

  def solve
    make_all_neighbours
    
    grid_changed_in_last_loop = true
    while !solved? && grid_changed_in_last_loop
      grid_changed_in_last_loop = grid_changed_by? { solve_all_cells }
    end
    try_harder unless solved?
  end

  def try_harder
    test_cell = cells_not_solved.first
    test_cell.possible_values.each do |possible_value|
      test_cell.assume possible_value
      test_grid = Grid.new(self.to_s)
      test_grid.solve
      if test_grid.solved?
        take_solution(test_grid.cells)
        break
      end
    end
  end

  def take_solution(cells)
    @cells = cells
  end

  def grid_changed_by?
    no_solved_before = cells_solved.count
    yield
    no_solved_after = cells_solved.count

    no_solved_before < no_solved_after
  end

  def solve_all_cells
    @cells.flatten.each { |cell| cell.solve }
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
    box_corners = [ [0, 0], [0, 3], [0, 6],
                    [3, 0], [3, 3], [3, 6],
                    [6, 0], [6, 3], [6, 6] ]
    row = box_corners[box][0]
    column = box_corners[box][1]
    [ @cells[row][column, 3],
      @cells[row+1][column, 3],
      @cells[row+2][column, 3] ].flatten
  end

  def to_s
    @cells.flatten.map(&:value).join
  end

  def inspect
    row_separator = ('-' * 37) + "\n"
    grid_as_string = row_separator
    @cells.each do |row|
      row_as_string = "|"
      row.each { |cell| row_as_string += " #{cell.value} |" }
      grid_as_string += row_as_string + "\n"
      grid_as_string += ('-' * 37) + "\n"
    end
    grid_as_string
  end

end

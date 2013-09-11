require 'cell'

class Grid
  attr_reader :cells

  def initialize(puzzle)
    @cells = create_cells_from(puzzle)
  end

  def create_cells_from(puzzle)
    numbers = puzzle.chars.map(&:to_i)
    cells = {}
    (1..9).each do |row|
      (1..9).each do |column|
        cell_name = "C#{column}R#{row}".to_sym
        cells[cell_name] = numbers.shift
      end
    end
    cells.each { |name, value| cells[name] = Cell.new(value) }
  end

  def solved?
    @cells.values.map(&:filled_out?).all?
  end
end
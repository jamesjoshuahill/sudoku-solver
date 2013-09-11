class Cell
  attr_reader :value, :neighbours

  def initialize(value)
    @value = value
    @neighbours = []
  end

  def filled_out?
    @value != 0
  end

  def add_neighbours(neighbours)
    @neighbours.concat(neighbours) if @neighbours.count < 28
  end

  def values_of_neighbours
    @neighbours.map(&:value) if @neighbours.count == 28
  end

  def possible_values
    (1..9).to_a - values_of_neighbours
  end

  def solve
    @value = possible_values.first if possible_values.count == 1
  end
end
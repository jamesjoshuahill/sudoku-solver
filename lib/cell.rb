class Cell
  attr_reader :value

  def initialize(value, neighbours)
    @value = value
    @neighbours = neighbours
  end

  def filled_out?
    @value != 0
  end

  def neighbours
    @neighbours
  end

  def values_of_neighbours
    @neighbours.map(&:value)
  end

  def possible_values
    (1..9).to_a - values_of_neighbours
  end

  def solve
    @value = possible_values.first if possible_values.count == 1
  end
end
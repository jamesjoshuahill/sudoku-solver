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
end
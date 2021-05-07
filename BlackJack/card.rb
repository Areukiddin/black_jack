class Card
  attr_reader :value, :name

  def initialize(name, suit, value)
    @name = name
    @suit = suit
    @value = value
  end

  def simple_view
    @name + @suit
  end

  private

  attr_reader :suit
end

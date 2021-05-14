class Card
  attr_reader :value, :name

  SUITS = ['♥', '♦', '♣', '♠'].freeze
  NAMES = %w[A 2 3 4 5 6 7 8 9 10 J Q K].freeze
  VALUES = [11, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10].freeze

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

require_relative 'card'

class Deck
  attr_accessor :cards

  SUITS = ['♥', '♦', '♣', '♠'].freeze
  NAMES = %w[A 2 3 4 5 6 7 8 9 10 J Q K].freeze
  VALUES = [[1, 11], [2], [3], [4], [5], [6], [7], [8], [9], [10], [10], [10], [10]].freeze

  def initialize
    @cards = []
    create_deck
  end

  def create_deck
    SUITS.each do |suit|
      NAMES.each_with_index do |name, index|
        @cards << Card.new(name, suit, VALUES[index])
      end
    end
    5.times { @cards.shuffle! }
  end
end

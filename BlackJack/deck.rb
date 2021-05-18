class Deck
  include Constants
  attr_accessor :cards

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
    @cards.shuffle!
  end
end

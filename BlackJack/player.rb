require_relative 'card'

class Player
  attr_reader :name, :hand, :bank, :score, :bet

  def initialize(name = 'Robot')
    @name = name
    @cash = 100
    @hand = []
    @score = 0
    @bet = 0
  end

  def place_bet(bet = 10)
    @cash -= bet unless @cash.zero?
    @bet = bet
  end

  def take(card)
    @hand << card.simple_view
    @score += if @hand.length < 3 && !card.name.eql?('A')
                card.value[0]
              elsif @hand.length < 3 && card.name.eql?('A')
                card.value[1]
              end
  end
end

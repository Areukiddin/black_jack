require_relative 'card'

class Player
  attr_reader :name
  attr_accessor :cash, :hand, :score, :bet

  def initialize(name = 'Dealer')
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
    @score += if (@hand.length < 3 && card.name.eql?('A')) || still_less_then_21?(card)
                card.value[1]
              else card.value[0]
              end
  end

  def take_cash(bank)
    @cash += bank
  end

  def reset
    @hand = []
    @score = 0
  end

  def score_less_then_21?
    return true if @score <= 21
  end

  def still_less_then_21?(card)
    return true if card.name.eql?('A') && @score + card.value[1] <= 21
  end
end

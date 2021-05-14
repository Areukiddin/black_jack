class Player
  attr_reader :name
  attr_accessor :cash, :hand, :bet

  def initialize(name = 'Dealer')
    @name = name
    @cash = 100
    @hand = Hand.new
    @bet = 0
  end

  def place_bet(bet = 10)
    @cash -= bet unless @cash.zero?
    @bet = bet
  end

  def take_cash(bank)
    @cash += bank
  end
end

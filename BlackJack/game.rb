require_relative 'deck'
require_relative 'player'
require_relative 'robot'

class Game
  def initialize
    @bank = 0
  end

  def start
    @deck = Deck.new
    @robot = Robot.new
    @player = Player.new('Player')
    give_cards
    take_bet
  end

  def give_cards
    2.times { @robot.take(@deck.cards.pop) }
    2.times { @player.take(@deck.cards.pop) }
  end

  def take_bet
    @robot.place_bet
    @player.place_bet
    @bank = @robot.bet + @player.bet
  end
end

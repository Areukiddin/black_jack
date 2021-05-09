require_relative 'deck'
require_relative 'player'
require_relative 'robot'

class Game
  attr_reader :started, :bank, :restart_enabled

  def initialize
    @bank = 0
    @started = false
    @restart_enabled = false
  end

  def start(name)
    @deck = Deck.new
    @robot = Robot.new
    @player = Player.new(name)
    initial_deal
    take_bet
    @started = true
  end

  def restart
    initial_deal
    take_bet
    @restart_enabled = false
  end

  def give_card(player)
    player.take(@deck.cards.pop)
  end

  def initial_deal
    2.times { @robot.take(@deck.cards.pop) }
    2.times { @player.take(@deck.cards.pop) }
  end

  def take_bet
    @robot.place_bet
    @player.place_bet
    @bank = @robot.bet + @player.bet
  end

  def end_game
    if player_win?
      @player.cash += @bank
      puts "#{@player.name} победил!"
    elsif dealer_win?
      @robot.cash += @bank
      puts "#{@robot.name} победил!"
    else
      @player.cash += @bank / 2
      @robot.cash += @bank / 2
      puts 'Ничья!'
    end
    puts "У дилера: #{@robot.score}"
    puts @robot.hand.to_s
    refresh_stats
  end

  private

  def player_win?
    return true if @player.score > @robot.score && @player.score_less_then_21? || !@robot.score_less_then_21?
  end

  def dealer_win?
    return true if @player.score < @robot.score && @robot.score_less_then_21? || !@player.score_less_then_21?
  end

  def refresh_stats
    @bank = 0
    @player.hand = []
    @player.score = 0
    @robot.hand = []
    @robot.score = 0
    @restart_enabled = true
  end
end

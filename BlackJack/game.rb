class Game
  attr_reader :started, :bank

  def initialize(interface)
    @bank = 0
    @started = false
    @interface = interface
    @interface.start_commands
    while (code = gets.strip)
      game_continue(code)
    end
  end

  def game_continue(code)
    case code
    when 's'
      start
    when '1'
      skip_turn(code)
    when '2'
      give_card(code)
    when '3'
      game_end
    when 'r'
      @interface.restart_game
      restart(code)
    when 'q'
      @interface.exit_game
    end
    game_end if three_cards
  end

  def start
    @deck = Deck.new
    @robot = Robot.new
    @player = Player.new(@interface.player_name)
    prepare_round
  end

  def game_hud
    system('clear')
    @interface.game_commands
    @interface.player_hud(@player, @started)
    @interface.player_hud(@robot, @started)
    @interface.show_bank(@bank)
  end

  def restart(command)
    (return unless command.eql?('r'))
    system('clear')
    prepare_round
  end

  def skip_turn(command)
    @robot.hand.take(@deck.cards.pop) if command == '1' && @robot.card_needed?
    game_hud
  end

  def give_card(command)
    @player.hand.take(@deck.cards.pop) if command == '2'
    game_hud
  end

  def initial_deal
    2.times { @robot.hand.take(@deck.cards.pop) }
    2.times { @player.hand.take(@deck.cards.pop) }
  end

  def take_bet
    @robot.place_bet
    @player.place_bet
    @bank = @robot.bet + @player.bet
  end

  def game_end
    system('clear')
    if player_win?
      @player.take_cash(bank)
      @interface.congrats(@player)
    elsif dealer_win?
      @robot.take_cash(bank)
      @interface.congrats(@robot)
    else
      @player.take_cash(@bank / 2)
      @robot.take_cash(@bank / 2)
      @interface.draw
    end
    @started = false
    show_result
  end

  private

  def prepare_round
    initial_deal
    take_bet
    @started = true
    game_hud
  end

  def both_less21
    @robot.hand.score_less_then_21? && @player.hand.score_less_then_21?
  end

  def player_over21
    @robot.hand.score_less_then_21? && !@player.hand.score_less_then_21?
  end

  def dealer_over21
    @player.hand.score_less_then_21? && !@robot.hand.score_less_then_21?
  end

  def player_win?
    return true if (both_less21 && @player.hand.score > @robot.hand.score) || dealer_over21
  end

  def dealer_win?
    return true if (both_less21 && @player.hand.score < @robot.hand.score) || player_over21
  end

  def three_cards
    @robot&.hand&.cards&.length == 3 && @player&.hand&.cards&.length == 3
  end

  def show_result
    @interface.player_hud(@player, @started)
    @interface.player_hud(@robot, @started)
    refresh_stats
    @player.hand = Hand.new
    @robot.hand = Hand.new
    @interface.restart_game
  end

  def refresh_stats
    @bank = 0
    @deck = Deck.new
  end
end

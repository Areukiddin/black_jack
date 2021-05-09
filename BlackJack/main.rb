require_relative 'game'

class Main
  def initialize
    @game = Game.new
  end

  def main
    loop do
      system('clear')
      main_menu
      first_command = command
      break if first_command == '0'

      case first_command
      when 's'
        option(menu_game_start)
      when 'r'
        option(menu_restart_game)
      when '1'
        option(menu_skip_turn)
      when '2'
        option(menu_take_card)
      when '3'
        option(menu_open_cards)
      end
      @game.end_game if @game.started && @player.hand.length == 3 && @robot.hand.length == 3
    end
  end

  def menu_game_start
    puts 'Введите своё имя'
    name = gets.chomp
    @game.start(name)
    @player = @game.instance_variable_get :@player
    @robot = @game.instance_variable_get :@robot
  end

  def menu_restart_game
    @game.restart
  end

  def menu_skip_turn
    @game.give_card(@robot) if @robot.card_needed? && !@game.restart_enabled
  end

  def menu_take_card
    return if @game.restart_enabled

    @game.give_card(@player) if @player.still_less_then_21?
    @game.give_card(@robot) if @robot.card_needed?
  end

  def menu_open_cards
    @game.end_game unless @game.restart_enabled
  end

  def command
    gets.chomp.downcase
  end

  def option(menu_option)
    menu_option
    gets
  end

  private

  def main_menu
    puts 'Нажмите s для старта' unless @game&.started
    return unless @game&.started

    puts 'Игровые команды:
    1 - Пропустить ход
    2 - Взять карту
    3 - Открыть карты
    0 - Выйти из игры'
    puts
    puts "У вас #{@player.score} очков"
    puts @player.hand.to_s unless @player.hand.length.zero?
    puts "Ваш счёт: #{@player.cash}$                 Счёт дилера: #{@robot.cash}$"
    puts "                Банк: #{@game.bank}$"
    puts 'Нажмите r для новой игры' if @game.restart_enabled
  end
end

main = Main.new
main.main

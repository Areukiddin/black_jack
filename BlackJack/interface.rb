require_relative 'player'

class Interface
  def start_commands
    system('clear')
    puts 'S - начать игру'
    puts 'Q - выйти'
  end

  def player_name
    puts 'Введите своё имя'
    name = gets.strip
    raise 'Name cannot be empty' unless name != ''

    name
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def command
    game_commands
    code = gets.strip
    exit_game if code == 'q'
    raise 'Неверная команда' unless %w[1 2 3].include? code

    code
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def game_commands
    system('clear')
    puts ''
    puts '1 - пропустить ход'
    puts '2 - взять карту'
    puts '3 - открыть карты'
    puts 'q - выход'
    puts ''
  end

  def player_hud(player, started)
    show_cards(player.hand, player, started)
    show_score(player.score) if !started || !dealer?(player.name) && started
    show_money(player.cash)
  end

  def show_cards(cards, player, started)
    puts "Рука игрока #{player.name}: #{dealer?(player.name) && started ? '*' * cards.length : cards}"
  end

  def show_score(score)
    puts "Очков: #{score}"
    puts ''
  end

  def show_money(money)
    puts "Деньги: #{money}$"
    puts '_______________'
    puts ''
  end

  def show_bank(bank)
    puts '                     _________________'
    puts "                    | Общий банк: #{bank}$ |"
    puts '                     -----------------'
  end

  def congrats(player)
    puts "#{player.name} победил!"
  end

  def draw
    puts 'Ничья!'
  end

  def restart_game
    puts 'Нажмите r чтобы начать заново'
  end

  def exit_game
    puts 'Пока!'
  end

  private

  def dealer?(name)
    name.eql?('Dealer')
  end
end

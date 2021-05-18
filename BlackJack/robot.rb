require_relative 'player'

class Robot < Player
  def card_needed?
    (return true unless @hand.score > 17)
    false
  end
end

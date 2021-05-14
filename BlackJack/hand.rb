class Hand
  attr_accessor :cards, :score

  def initialize
    @cards = []
    @score = 0
  end

  def take(card)
    @cards << card.simple_view
    @score += if card.name.eql?('A') && !still_less_then_21?(card)
                card.value - 10
              else
                card.value
              end
  end

  def score_less_then_21?
    return true if @score <= 21
  end

  def still_less_then_21?(card)
    return true if card.name.eql?('A') && @score + card.value <= 21
  end
end

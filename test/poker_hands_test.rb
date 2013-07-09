require './lib/poker_hands'

def confirm(message)
  if yield
    puts ". (#{message})"
  else
    puts "F (#{message})"
  end
end

KING_HIGH       = %w[KH 4H 8D 2D 9C]
ACE_HIGH        = %w[AH 6H 4D 9D QC]
ONE_PAIR        = %w[JS JD 4C 6C 9C]
TWO_PAIR        = %w[QS QD 7C 7C 9C]
THREE_OF_A_KIND = %w[3S 3D 3C QC JC]
STRAIGHT        = %w[3D 4S 5S 6C 7S]
FLUSH           = %w[3S QS 5S AS 7S]
FULL_HOUSE      = %w[AS AD AC 9H 9C]
FOUR_OF_A_KIND  = %w[TS TD TC TH 9C]
STRAIGHT_FLUSH  = %w[6S 7S 8S 9S TS]


confirm 'Ace high beats King high' do
  Game.new(ACE_HIGH, KING_HIGH).winner == 'Hand 1 wins with ace_high'
end

confirm 'One pair beats Ace high' do
  Game.new(ONE_PAIR, ACE_HIGH).winner == 'Hand 1 wins with one_pair'
end

confirm 'Two pair beats One pair' do
  Game.new(ONE_PAIR, TWO_PAIR).winner == 'Hand 2 wins with two_pair'
end

confirm 'Three of a kind beats Two pair' do
  Game.new(THREE_OF_A_KIND, TWO_PAIR).winner == 'Hand 1 wins with three_of_a_kind'
end

confirm 'Straight beats Three of a kind' do
  Game.new(STRAIGHT, THREE_OF_A_KIND).winner == 'Hand 1 wins with straight'
end

confirm 'Flush beats Straight' do
  Game.new(STRAIGHT, FLUSH).winner == 'Hand 2 wins with flush'
end

confirm 'Full house beats Flush' do
  Game.new(FULL_HOUSE, FLUSH).winner == 'Hand 1 wins with full_house'
end

confirm 'Four of a kind beats Full House' do
  Game.new(FOUR_OF_A_KIND, FULL_HOUSE).winner == 'Hand 1 wins with four_of_a_kind'
end

confirm 'Straight Flush beats Four of a kind' do
  Game.new(FOUR_OF_A_KIND, STRAIGHT_FLUSH).winner == 'Hand 2 wins with straight_flush'
end

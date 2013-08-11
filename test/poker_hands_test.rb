require './lib/poker_hands'

def confirm(message)
  if yield
    puts ". (#{message})"
  else
    puts "F (#{message})"
  end
end

KING_HIGH       = %w[4H 8D KH 2D 9C]
ACE_HIGH        = %w[3H 4D 9D AH QC]
ONE_PAIR_JACK   = %w[JS JD AC 6C 9C]
ONE_PAIR_QUEEN  = %w[QS QD 3C 6C 8C]
TWO_PAIR        = %w[QS QD 7C 7C 9C]
THREE_THREES    = %w[3S 3D 3C QC JC]
THREE_EIGHTS    = %w[2S 8D 3C 8C 8C]
STRAIGHT        = %w[3D 4S 5S 6C 7S]
FLUSH           = %w[3S QS 5S AS 7S]
FULL_HOUSE      = %w[AS AD AC 9H 9C]
FOUR_OF_A_KIND  = %w[TS TD TC TH 9C]
STRAIGHT_FLUSH  = %w[6S 7S 8S 9S TS]
ROYAL_FLUSH     = %w[JS AS QS KS TS]


confirm 'Ace high beats King high' do
  Game.new(ACE_HIGH, KING_HIGH).winner == 'Hand 1 wins with high_card'
end

confirm 'One pair beats Ace high' do
  Game.new(ONE_PAIR_JACK, ACE_HIGH).winner == 'Hand 1 wins with one_pair'
end

confirm 'Two pair beats One pair' do
  Game.new(ONE_PAIR_JACK, TWO_PAIR).winner == 'Hand 2 wins with two_pair'
end

confirm 'One pair queens beats One pair jacks' do
  Game.new(ONE_PAIR_JACK, ONE_PAIR_QUEEN).winner == 'Hand 2 wins with one_pair'
end

confirm 'Three of a kind beats Two pair' do
  Game.new(THREE_THREES, TWO_PAIR).winner == 'Hand 1 wins with three_of_a_kind'
end

confirm 'Three eights beats three threes' do
  Game.new(THREE_THREES, THREE_EIGHTS).winner == 'Hand 2 wins with three_of_a_kind'
end

confirm 'Straight beats Three of a kind' do
  Game.new(STRAIGHT, THREE_THREES).winner == 'Hand 1 wins with straight'
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

confirm 'Royal Flush beats Straight Flush' do
  Game.new(ROYAL_FLUSH, STRAIGHT_FLUSH).winner == 'Hand 1 wins with straight_flush'
end

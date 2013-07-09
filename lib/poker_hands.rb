Game = Class.new do
  def initialize(cards_1, cards_2)
    self.hand_1 = Hand.new(cards_1)
    self.hand_2 = Hand.new(cards_2)
  end

  def winner
    if hand_1 > hand_2
      "Hand 1 wins with #{hand_1.value}"
    elsif hand_1 < hand_2
      "Hand 2 wins with #{hand_2.value}"
    else
      puts 'equal'
    end
  end

  private
  attr_accessor :hand_1, :hand_2
end

Hand = Class.new do
  include Comparable

  HAND_RANK = [
      :high_card,
      :one_pair,
      :two_pair,
      :three_of_a_kind,
      :straight,
      :flush,
      :full_house,
      :four_of_a_kind,
      :straight_flush,
    ]

  def initialize(hand)
    self.cards = hand.map { |c| Card.new(c) }
  end

  def value
    @value ||= HAND_RANK.detect { |hr| send("#{hr}?") }
  end

  private
  attr_accessor :cards

  def <=>(other)
    HAND_RANK.index(value) <=> HAND_RANK.index(other.value)
  end

  def high_card?
    cards_with_matching_values.empty? &&
      !sorted_cards_have_adjacent_values? &&
      !all_suits_match?
  end

  def one_pair?
    cards_with_matching_values.count == 2
  end

  def two_pair?
    cards_with_matching_values.count == 4 &&
      !all_matching_cards_equal_value?
  end

  def three_of_a_kind?
    cards_with_matching_values.count == 3
  end

  def straight?
    sorted_cards_have_adjacent_values? && !all_suits_match?
  end

  def flush?
    all_suits_match? && !sorted_cards_have_adjacent_values?
  end

  def full_house?
    cards_with_matching_values.count == 5
  end

  def four_of_a_kind?
    cards_with_matching_values.count == 4 && all_matching_cards_equal_value?
  end

  def straight_flush?
    all_suits_match? && sorted_cards_have_adjacent_values?
  end

  def cards_with_matching_values
    @cards_with_matching_values ||=
      cards.map { |c| (cards - [c]).select { |d| d == c } }.flatten.uniq
  end

  def all_matching_cards_equal_value?
    @all_matching_cards_equal_value ||=
      cards_with_matching_values.all? { |c| c == cards_with_matching_values.first }
  end

  def sorted_cards_have_adjacent_values?
    @sorted_cards_have_adjacent_values ||=
      cards.sort.each_cons(2).all? { |first, last| first.adjacent_value_to? last }
  end

  def all_suits_match?
    @all_suits_match ||= cards.all? { |c| c.suit == cards.first.suit }
  end
end

Card = Class.new do
  include Comparable

  attr_reader :value, :suit

  CARD_RANK = %w(2 3 4 5 6 7 8 9 T J Q K A)

  def initialize(card)
    /(?<value>^[2-9TAKQJ])(?<suit>[CDHS]$)/ =~ card
    self.value = value
    self.suit = suit
  end

  def adjacent_value_to?(other)
    (card_rank_index(value) + 1) == card_rank_index(other.value)
  end

  private
  attr_writer :value, :suit

  def <=>(other)
    card_rank_index(value) <=> card_rank_index(other.value)
  end

  def card_rank_index(value)
    CARD_RANK.index value
  end

  def to_s
    "#{value}#{suit}"
  end
end

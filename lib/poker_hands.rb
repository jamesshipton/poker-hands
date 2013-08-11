module Enumerable
  def sort_by_frequency
    histogram = each_with_object(Hash.new(0)) { |x, hash| hash[x.value] += 1 }
    sort_by { |x| [histogram[x.value], x] }
  end
end

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
      compare_cards hand_1.cards, hand_2.cards
    end
  end

  private
  attr_accessor :hand_1, :hand_2

  def compare_cards(hand_1_cards, hand_2_cards)
    hand_1_card = hand_1_cards.pop
    hand_2_card = hand_2_cards.pop

    if hand_1_card > hand_2_card
      "Hand 1 wins with #{hand_1.value}"
    elsif hand_2_card > hand_1_card
      "Hand 2 wins with #{hand_2.value}"
    else
      compare_cards hand_1_cards, hand_2_cards
    end
  end
end

Hand = Class.new do
  include Comparable

  attr_reader :cards

  HAND_RANK = [
    :straight_flush,
    :four_of_a_kind,
    :full_house,
    :flush,
    :straight,
    :three_of_a_kind,
    :two_pair,
    :one_pair,
    :high_card,
  ]

  def initialize(card_names)
    self.cards = card_names.map { |c| Card.new(c) }.sort_by_frequency
  end

  def value
    @value ||= HAND_RANK.detect { |hr| send("#{hr}?") }
  end

  private
  attr_writer :cards

  def <=>(other)
    HAND_RANK.index(other.value) <=> HAND_RANK.index(value)
  end

  def high_card?
    cards_with_matching_values.empty? &&
      !cards_have_adjacent_values? &&
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
    cards_have_adjacent_values? && !all_suits_match?
  end

  def flush?
    all_suits_match? && !cards_have_adjacent_values?
  end

  def full_house?
    cards_with_matching_values.count == 5
  end

  def four_of_a_kind?
    cards_with_matching_values.count == 4 && all_matching_cards_equal_value?
  end

  def straight_flush?
    all_suits_match? && cards_have_adjacent_values?
  end

  def cards_with_matching_values
    @cards_with_matching_values ||=
      cards.map { |c| (cards - [c]).select { |d| d == c } }.flatten.uniq
  end

  def all_matching_cards_equal_value?
    @all_matching_cards_equal_value ||=
      cards_with_matching_values.all? { |c| c == cards_with_matching_values.first }
  end

  def cards_have_adjacent_values?
    @cards_have_adjacent_values ||=
      cards.each_cons(2).all? { |first, last| first.adjacent_value_to? last }
  end

  def all_suits_match?
    @all_suits_match ||= cards.all? { |c| c.suit == cards.first.suit }
  end
end

Card = Class.new do
  include Comparable

  attr_reader :value, :suit

  CARD_RANK = %w(A K Q J T 9 8 7 6 5 4 3 2)

  def initialize(card)
    /(?<value>^[2-9TAKQJ])(?<suit>[CDHS]$)/ =~ card
    self.value = value
    self.suit = suit
  end

  def adjacent_value_to?(other)
    card_rank_index(value) == card_rank_index(other.value) + 1
  end

  private
  attr_writer :value, :suit

  def <=>(other)
    card_rank_index(other.value) <=> card_rank_index(value)
  end

  def card_rank_index(value)
    CARD_RANK.index value
  end

  def to_s
    "#{value}#{suit}"
  end
end

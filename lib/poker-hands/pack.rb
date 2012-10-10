module PokerHands
  class Pack
    def initialize
      @cards = %w(H D C S).map do |suit|
        %w(A 2 3 4 5 6 7 8 9 10 J Q K).map do |value|
          PokerHands::Card.new(suit, value)
        end
      end.flatten
    end

    def deal_hand
      PokerHands::Hand.new select_5_random_cards
    end

    private
    def select_5_random_cards
      (1..5).map { @cards.delete(@cards.sample) }
    end
  end
end
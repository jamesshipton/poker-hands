module PokerHands
  class Dealer
    def self.deal_hands(players)
      players.each { |p| p.hand = pack.deal_hand }
    end

    def self.pack
      @pack ||= PokerHands::Pack.new
    end
  end
end
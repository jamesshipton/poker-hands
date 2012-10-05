module PokerHands
  class Round
    def initialize(*players)
      @players = PokerHands::Players.new(players)
    end
  end
end
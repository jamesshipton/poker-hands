module PokerHands
  class Round
    def initialize(*players)
      @players = players.map { |p| PokerHands::Player.new(p) }
    end
  end
end
module PokerHands
  class Round
    def initialize(*players)
      @players = PokerHands::Players.new(players)
    end

    def display_winner
      PokerHands::ResultOutputter.display "And the winner is #{@players.winners_name}"
    end
  end
end
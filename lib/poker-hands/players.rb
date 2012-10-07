module PokerHands
  class Players
    def initialize(player_names)
      player_list = player_names.map { |name| PokerHands::Player.new name }
      PokerHands::Dealer.deal_hands player_list
    end
  end
end
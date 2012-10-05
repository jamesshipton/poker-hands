require 'spec_helper'

describe PokerHands::Round do
  subject { PokerHands::Round.new(*player_names) }

  let(:players)      { double('players', winners_name: 'player1') }
  let(:player_names) { ['player1', 'player2'] }

  describe '#initialize' do
    it 'creates new players' do
      PokerHands::Players.should_receive(:new).with(player_names).and_return(players)
      subject
    end
  end
end
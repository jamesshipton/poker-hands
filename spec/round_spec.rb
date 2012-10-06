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

  describe '#display_winner' do
    it 'returns the winning player' do
      PokerHands::Players.stub(:new).and_return(players)
      players.stub(winners_name: 'player1')
      PokerHands::ResultOutputter.should_receive(:display).with('And the winner is player1')
      subject.display_winner
    end
  end
end
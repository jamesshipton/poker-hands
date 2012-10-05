require 'spec_helper'

describe PokerHands::Round do
  subject { PokerHands::Round.new(*players) }

  context '2 players' do
    let(:players) { ['player1', 'player2'] }

    it 'creates 2 new players' do
      PokerHands::Player.should_receive(:new).once.with('player1')
      PokerHands::Player.should_receive(:new).once.with('player2')
      subject
    end
  end
end
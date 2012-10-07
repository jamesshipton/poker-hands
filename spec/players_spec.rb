require 'spec_helper'

describe PokerHands::Players do
  subject { PokerHands::Players.new(player_names) }

  let(:player_names) { ['player1', 'player2'] }
  let(:player1)      { double('player1') }
  let(:player2)      { double('player2') }
  let(:player_list)  { [player1, player2] }

  before(:each) do
    PokerHands::Player.stub(:new).with('player1').and_return(player1)
    PokerHands::Player.stub(:new).with('player2').and_return(player2)
    PokerHands::Dealer.stub(:deal_hands)
  end

  describe '#initialize' do
    it 'creates new players' do
      PokerHands::Player.should_receive(:new).once.with('player1')
      PokerHands::Player.should_receive(:new).once.with('player2')
      subject
    end

    it 'deals a hand to each player' do
      PokerHands::Dealer.should_receive(:deal_hands).with(player_list)
      subject
    end
  end
end
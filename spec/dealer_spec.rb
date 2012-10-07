require 'spec_helper'

describe PokerHands::Dealer do
  describe '#deal_hands' do
    subject { PokerHands::Dealer.deal_hands(players) }

    let(:player1) { double('player1') }
    let(:player2) { double('player2') }
    let(:players) { [player1, player2] }

    let(:hand1)   { double('hand1') }
    let(:hand2)   { double('hand2') }

    let(:pack)    { double('pack') }

    it 'deals a hand from the pack to each player' do
      PokerHands::Pack.should_receive(:new).once.and_return(pack)
      pack.should_receive(:deal_hand).and_return(hand1, hand2)
      player1.should_receive(:hand=).with(hand1)
      player2.should_receive(:hand=).with(hand2)
      subject
    end
  end
end
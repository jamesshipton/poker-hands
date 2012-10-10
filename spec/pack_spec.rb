require 'spec_helper'

describe PokerHands::Pack do

  let(:card) { double('card') }

  describe '#initialize' do
    before(:each) do
      PokerHands::Card.stub(new: card)
    end

    it 'create 52 cards' do
      subject.instance_variable_get(:@cards).size.should == 52
    end

    it 'creates a 2D card' do
      PokerHands::Card.should_receive(:new).once.with('D', '2')
      subject
    end

    it 'creates a AS card' do
      PokerHands::Card.should_receive(:new).once.with('S', 'A')
      subject
    end
  end

  describe '#deal_hand' do
    it 'chooses 5 different cards' do
      subject.deal_hand.uniq.size.should == 5
    end

    it 'removes the chosen cards from the pack' do
      (pack = subject).deal_hand
      pack.instance_variable_get(:@cards).size.should == 47
    end
  end
end
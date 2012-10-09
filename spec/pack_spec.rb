require 'spec_helper'

describe PokerHands::Pack do

  let(:card) { double('card') }

  before(:each) do
    PokerHands::Card.stub(:new)
  end

  describe '#initialize' do
    it 'create 52 cards' do
      PokerHands::Card.should_receive(:new).exactly(52).times
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
end
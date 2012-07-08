require 'poker_hands'

describe PokerHands::Round do
  context 'Jim has 2C,3D,5S,6S,9H and Bob has 2C,3D,5S,6S,9H' do
    it 'declare Jim as the winner with king high' do
      PokerHands::ResultOutputter.should_receive(:display).with('Jim is the winner with king high')
      PokerHands::Round.play('Jim', 'Bob')
    end
  end
end

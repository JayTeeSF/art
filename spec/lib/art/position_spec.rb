require 'spec_helper'

describe Art::Position do
  let(:pos) { Art::Position.new( ) }
  describe "creation" do
    it "initializes a position at 0,0" do
      expect(pos).to eq( Art::Position.new(0,0) )
    end
  end

  describe "equivalence" do
    it "considers two positions with the same coordinates as the same" do
      expect( pos ).to eq( pos )
      expect( pos ).to eq( Art::Position.new(0,0) )
      expect( Art::Position.new(:x,:y) ).to eq( Art::Position.new(:x,:y) )
    end
  end

  describe "conversion" do
    it "converts to an [x,y] array" do
      expect(pos.to_a).to eq( [0,0] )
      expect(Art::Position.new(:x, :y).to_a).to eq( [:x,:y] )
    end
  end
end

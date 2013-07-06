require 'spec_helper'

describe Art do
  describe "creation" do
    let(:start_position) { Art::Position.new(0,0) }
    context "Given no arguments" do
      let(:art) { Art.new( ) }
    end
    context "Given a valid canvas" do
      let(:canvas) { Art::Canvas.new }
      let(:art) { Art.new( canvas ) }

      it "returns the current position as 0,0" do
        expect( art.current_position ).to eq( start_position )
      end
    end

    context "Given an invalid canvas" do
      let(:canvas) { nil }
      let(:art) { Art.new( canvas ) }
    end
  end
end

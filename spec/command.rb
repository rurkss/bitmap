require_relative "../lib/bitmap_editor"

RSpec.describe BitmapEditor do

  subject { b_editor }
  before { b_editor.init([3,5]) }

  let(:b_editor) { BitmapEditor.new }

  describe "#init" do

    context "command 'I'" do

      it "dimention 3X5" do
        expect(subject.bit_map.first.size).to eq 3
        expect(subject.bit_map.size).to eq 5
      end
    end
  end
end

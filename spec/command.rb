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

  describe "#color" do

    context "command 'L'" do

      it "set color 'Z' to 2,3" do
        b_editor.color([2,3,"Z"])
        expect(subject.bit_map[2][1]).to eq "Z"
        expect(subject.bit_map.flatten.uniq).to match_array(["O", "Z"])
      end
    end
  end

  describe "#clear" do

    context "command 'C'" do

      it "reset bits to 'O'" do
        b_editor.color([2,3,"Z"])
        b_editor.clear()
        expect(subject.bit_map.flatten.uniq).to match_array(["O"])
      end
    end
  end

end

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

  describe "#vertical" do
    context "command 'V'" do

      it "set color 'Z' in column 3 between rows 2 and 4" do
        # O | O | O
        # O | O | Z
        # O | O | Z
        # O | O | Z
        # O | O | O
        b_editor.vertical([3,2,4,"Z"])
        bitmap = subject.bit_map.flatten
        expect(bitmap.each_index.select{|i| bitmap[i] == 'Z'}).to match_array([5,8,11])
      end
    end
  end

end

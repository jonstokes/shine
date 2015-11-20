require 'spec_helper'

describe Shine::Category do
  context "validations" do
    subject { create(:category) }

    it { is_expected.to be_valid }

    it "requires a cid" do
      subject.cid = nil
      expect(subject).not_to be_valid
    end
  end

  describe "mapping attributes" do
    it "translates a category item into an attributes hash" do
      item = Shine::Item.new load_request(type: "category", action: "publish")
      expect(Shine::Category.item_to_attributes(item)).to eq(
        cid: "4Zk6ihvUM8Y0GcYiY24sq",
        title: "Dogs",
        icon_cid: "6JCShApjO0O4CUkUKAKAaS",
      )
    end
  end
end
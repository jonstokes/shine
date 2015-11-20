require 'spec_helper'

describe Shine::Author do

  context "validations" do
    subject { create(:author) }

    it { is_expected.to be_valid }

    it "requires a cid" do
      subject.cid = nil
      expect(subject).not_to be_valid
    end

    it "requires a name" do
      subject.name = nil
      expect(subject).not_to be_valid
    end
  end

  describe "mapping attributes" do
    it "translates an author item into an attributes hash" do
      item = Shine::Item.new load_request(type: "author", action: "publish")
      expect(Shine::Author.item_to_attributes(item)).to eq(
        cid:               "3kTFGSVVi86OGOcA6ckqsk",
        name:              "Jon Stokes",
        website:           "http://jonstokes.com",
        biography:         "Jon Stokes is a swell guy.",
        profile_photo_cid: "2ReMHJhXoAcy4AyamgsgwQ"
      )
    end
  end
end
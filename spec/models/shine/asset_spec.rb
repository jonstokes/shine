require 'spec_helper'

describe Shine::Asset do
  context "validations" do
    subject { create(:asset) }

    it { is_expected.to be_valid }

    it "requires a cid" do
      subject.cid = nil
      expect(subject).not_to be_valid
    end

    it "requires a file" do
      subject.file = {}
      expect(subject).not_to be_valid
    end

    it "requires file to have a valid format" do
      pending "Add a JSON schema validator"
      expect(false).to eq(true)
    end
  end

  describe "mapping attributes" do
    it "translates an asset item into an attributes hash" do
      item = Shine::Item.new load_request(type: "asset", action: "publish")
      expect(Shine::Asset.item_to_attributes(item)).to eq(
        cid: "7BCHkLHgIMuGSg2SqCQyaK",
        title: "Jon Stokes headshot",
        description: "My headshot from Wired",
        file: {
          "fileName" => "headshot2.jpg",
          "contentType" => "image/jpeg",
          "details" => {
            "image" => {
              "width" => 402,
              "height" => 604
            },
            "size" => 29962
          },
          "url" => "//images.contentful.com/rwvjblw7dr6a/7BCHkLHgIMuGSg2SqCQyaK/d617beca0d5d5bc9fa7704be70883c12/headshot2.jpg"
        }
      )
    end
  end
end
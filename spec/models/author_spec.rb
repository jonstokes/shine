require 'spec_helper'

describe Author do

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

  context "Mappers" do
    let(:expected_hash) {
      {
        cid:               "3kTFGSVVi86OGOcA6ckqsk",
        name:              "Jon Stokes",
        website:           "http://jonstokes.com",
        biography:         "Jon Stokes is a swell guy.",
        profile_photo_cid: "2ReMHJhXoAcy4AyamgsgwQ"
      }
    }

    describe RequestMapper do
      describe "#to_hash" do
        it "translates a webhook POST call's request body into an attributes hash" do
          params = JSON.load(Rails.root.join('spec', 'fixtures', 'requests', 'author', 'ContentManagement.Entry.publish.json'))
          mapper = Author::RequestMapper.new(params)
          expect(mapper.to_hash).to eq(expected_hash)
        end
      end
    end

    describe ObjectMapper do
      describe "#to_hash" do
        it "translates a Contentful::Entry object into an attributes hash" do
          mapper = Author::ObjectMapper.new(
            author_double(
              id: "3kTFGSVVi86OGOcA6ckqsk",
              fields: {
                name:          "Jon Stokes",
                website:       "http://jonstokes.com",
                biography:     "Jon Stokes is a swell guy.",
                profile_photo: asset_double(id: "2ReMHJhXoAcy4AyamgsgwQ")
              }
            )
          )
          expect(mapper.to_hash).to eq(expected_hash)
        end
      end
    end
  end
end
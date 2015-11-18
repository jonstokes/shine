require 'spec_helper'

describe Asset do
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

  context "Mappers" do
    let(:expected_hash) {
      {
        cid: "7BCHkLHgIMuGSg2SqCQyaK",
        title: "Jon Stokes headshot",
        description: "My headshot from Wired",
        file: {
          fileName: "headshot2.jpg",
          contentType: "image/jpeg",
          details: {
            image: {
              width: 402,
              height: 604
            },
            size: 29962
          },
          url: "//images.contentful.com/rwvjblw7dr6a/7BCHkLHgIMuGSg2SqCQyaK/d617beca0d5d5bc9fa7704be70883c12/headshot2.jpg"
        }
      }
    }

    describe RequestMapper do
      describe "#to_hash" do
        it "translates a webhook POST call's request body into an attributes hash" do
          params = JSON.load(Rails.root.join('spec', 'fixtures', 'requests', 'asset', 'ContentManagement.Asset.publish.json'))
          mapper = Asset::RequestMapper.new(params)
          expected_hash[:file].deep_stringify_keys!
          expect(mapper.to_hash).to eq(expected_hash)
        end
      end
    end

    describe ObjectMapper do
      describe "#to_hash" do
        it "translates a Contentful::Asset object into an attributes hash" do
          mapper = Asset::ObjectMapper.new(
            asset_double(
              id: "7BCHkLHgIMuGSg2SqCQyaK",
              fields: {
                title: "Jon Stokes headshot",
                description: "My headshot from Wired",
                file: file_double(properties: expected_hash[:file])
              }
            )
          )
          expect(mapper.to_hash).to eq(expected_hash)
        end
      end
    end
  end
end
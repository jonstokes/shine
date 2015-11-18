require 'spec_helper'

describe Category do
  context "validations" do
    subject { create(:category) }

    it { is_expected.to be_valid }

    it "requires a cid" do
      subject.cid = nil
      expect(subject).not_to be_valid
    end
  end

  context "Mappers" do
    let(:expected_hash) {
      {
        cid: "4Zk6ihvUM8Y0GcYiY24sq",
        title: "Dogs",
        icon_cid: "6JCShApjO0O4CUkUKAKAaS",
      }
    }

    describe RequestMapper do
      describe "#to_hash" do
        it "translates a webhook POST call's request body into an attributes hash" do
          params = load_source(type: "category", action: "publish")
          mapper = Category::RequestMapper.new(params)

          expect(mapper.to_hash).to eq(expected_hash)
        end
      end
    end

    describe ObjectMapper do
      describe "#to_hash" do
        it "translates a Contentful::Category object into an attributes hash" do
          mapper = Category::ObjectMapper.new(
            category_double(
              id: "4Zk6ihvUM8Y0GcYiY24sq",
              fields: {
                icon: asset_double(id: "6JCShApjO0O4CUkUKAKAaS")
              }
            )
          )
          expect(mapper.to_hash).to eq(expected_hash)
        end
      end
    end
  end
end
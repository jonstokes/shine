require 'spec_helper'

describe Content::Item do
  let(:entry) { load_request(type: "post", action: "publish") }
  let(:item) { Content::Item.new(entry) }

  describe "Published Entry" do
    it "wraps a published entry from a webhook call" do
      expect(item[:title]).to eq(entry['fields']['title'][Content.locale])
      expect(item[:slug]).to eq(entry['fields']['slug'][Content.locale])
      expect(item[:body]).to eq(entry['fields']['body'][Content.locale])
      expect(item[:author]).to eq(entry['fields']['author'][Content.locale])
      expect(item.id).to eq(entry['sys']['id'])
      expect(item.klass).to eq(Post)
      expect(item.type).to eq("Entry")
      expect(item.record?).to eq(true)
    end

    it "wraps a published entry from a sync session" do
    end
  end
end
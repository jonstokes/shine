require 'spec_helper'

describe Content::Item do
  describe "Published Entry" do
    it "wraps a published entry from a webhook call" do
      entry = load_request(type: "post", action: "publish")
      item = Content::Item.new(entry)

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
      entry = load_sync("all")['items'].first
      item = Content::Item.new(entry)

      expect(item[:title]).to eq(entry['fields']['title'][Content.locale])
      expect(item[:slug]).to eq(entry['fields']['slug'][Content.locale])
      expect(item[:body]).to eq(entry['fields']['body'][Content.locale])
      expect(item[:author]).to eq(entry['fields']['author'][Content.locale])
      expect(item.id).to eq(entry['sys']['id'])
      expect(item.klass).to eq(Post)
      expect(item.type).to eq("Entry")
      expect(item.record?).to eq(true)
    end
  end

  describe "Published Asset" do
    it "wraps a published asset from a webhook call" do
      asset = load_request(type: "asset", action: "publish")
      item = Content::Item.new(asset)

      expect(item[:title]).to eq(asset['fields']['title'][Content.locale])
      expect(item[:file]).to eq(asset['fields']['file'][Content.locale])
      expect(item[:description]).to eq(asset['fields']['description'][Content.locale])
      expect(item.id).to eq(asset['sys']['id'])
      expect(item.klass).to eq(Asset)
      expect(item.type).to eq("Asset")
      expect(item.record?).to eq(true)
    end

    it "wraps a published asset from a sync session" do
      asset = load_sync("all")['items'][7]
      item = Content::Item.new(asset)

      expect(item[:title]).to eq(asset['fields']['title'][Content.locale])
      expect(item[:file]).to eq(asset['fields']['file'][Content.locale])
      expect(item[:description]).to eq(asset['fields']['description'][Content.locale])
      expect(item.id).to eq(asset['sys']['id'])
      expect(item.klass).to eq(Asset)
      expect(item.type).to eq("Asset")
      expect(item.record?).to eq(true)
    end
  end

  describe "Deleted Entry" do
    it "wraps a deleted entry from a webhook call" do
      entry = load_request(type: "post", action: "unpublish")
      item = Content::Item.new(entry)

      expect(item.id).to eq(entry['sys']['id'])
      expect(item.klass).to be_nil
      expect(item.type).to eq("DeletedEntry")
      expect(item.record?).to eq(false)
    end

    it "wraps a deleted entry from a sync session" do
      entry = load_sync("deletion")['items'].last
      item = Content::Item.new(entry)

      expect(item.id).to eq(entry['sys']['id'])
      expect(item.klass).to be_nil
      expect(item.type).to eq("DeletedEntry")
      expect(item.record?).to eq(false)
    end
  end

  describe "DeletedAsset" do
    it "wraps a deleted asset from a webhook call" do
      asset = load_request(type: "asset", action: "unpublish")
      item = Content::Item.new(asset)

      expect(item.id).to eq(asset['sys']['id'])
      expect(item.klass).to be_nil
      expect(item.type).to eq("DeletedAsset")
      expect(item.record?).to eq(false)
    end

    it "wraps a deleted asset from a sync session" do
      entry = load_sync("deletion")['items'].first
      item = Content::Item.new(entry)

      expect(item.id).to eq(entry['sys']['id'])
      expect(item.klass).to be_nil
      expect(item.type).to eq("DeletedAsset")
      expect(item.record?).to eq(false)
    end
  end
end
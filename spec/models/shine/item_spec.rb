require 'spec_helper'

describe Shine::Item do
  describe "Published Entry" do
    it "wraps a published entry from a webhook call" do
      entry = load_request(type: "post", action: "publish")
      item = Shine::Item.new(entry)

      expect(item[:title]).to eq(entry['fields']['title'][Shine.locale])
      expect(item[:slug]).to eq(entry['fields']['slug'][Shine.locale])
      expect(item[:body]).to eq(entry['fields']['body'][Shine.locale])
      expect(item[:author]).to eq(entry['fields']['author'][Shine.locale])
      expect(item.id).to eq(entry['sys']['id'])
      expect(item.klass).to eq(Shine::Post)
      expect(item.type).to eq("Entry")
      expect(item.record?).to eq(true)
    end

    it "wraps a published entry from a sync session" do
      entry = load_sync("all")['items'].first
      item = Shine::Item.new(entry)

      expect(item[:title]).to eq(entry['fields']['title'][Shine.locale])
      expect(item[:slug]).to eq(entry['fields']['slug'][Shine.locale])
      expect(item[:body]).to eq(entry['fields']['body'][Shine.locale])
      expect(item[:author]).to eq(entry['fields']['author'][Shine.locale])
      expect(item.id).to eq(entry['sys']['id'])
      expect(item.klass).to eq(Shine::Post)
      expect(item.type).to eq("Entry")
      expect(item.record?).to eq(true)
    end
  end

  describe "Published Asset" do
    it "wraps a published asset from a webhook call" do
      asset = load_request(type: "asset", action: "publish")
      item = Shine::Item.new(asset)

      expect(item[:title]).to eq(asset['fields']['title'][Shine.locale])
      expect(item[:file]).to eq(asset['fields']['file'][Shine.locale])
      expect(item[:description]).to eq(asset['fields']['description'][Shine.locale])
      expect(item.id).to eq(asset['sys']['id'])
      expect(item.klass).to eq(Shine::Asset)
      expect(item.type).to eq("Asset")
      expect(item.record?).to eq(true)
    end

    it "wraps a published asset from a sync session" do
      asset = load_sync("all")['items'][7]
      item = Shine::Item.new(asset)

      expect(item[:title]).to eq(asset['fields']['title'][Shine.locale])
      expect(item[:file]).to eq(asset['fields']['file'][Shine.locale])
      expect(item[:description]).to eq(asset['fields']['description'][Shine.locale])
      expect(item.id).to eq(asset['sys']['id'])
      expect(item.klass).to eq(Shine::Asset)
      expect(item.type).to eq("Asset")
      expect(item.record?).to eq(true)
    end
  end

  describe "Deleted Entry" do
    it "wraps a deleted entry from a webhook call" do
      entry = load_request(type: "post", action: "unpublish")
      item = Shine::Item.new(entry)

      expect(item.id).to eq(entry['sys']['id'])
      expect(item.klass).to be_nil
      expect(item.type).to eq("DeletedEntry")
      expect(item.record?).to eq(false)
    end

    it "wraps a deleted entry from a sync session" do
      entry = load_sync("deletion")['items'].last
      item = Shine::Item.new(entry)

      expect(item.id).to eq(entry['sys']['id'])
      expect(item.klass).to be_nil
      expect(item.type).to eq("DeletedEntry")
      expect(item.record?).to eq(false)
    end
  end

  describe "DeletedAsset" do
    it "wraps a deleted asset from a webhook call" do
      asset = load_request(type: "asset", action: "unpublish")
      item = Shine::Item.new(asset)

      expect(item.id).to eq(asset['sys']['id'])
      expect(item.klass).to be_nil
      expect(item.type).to eq("DeletedAsset")
      expect(item.record?).to eq(false)
    end

    it "wraps a deleted asset from a sync session" do
      entry = load_sync("deletion")['items'].first
      item = Shine::Item.new(entry)

      expect(item.id).to eq(entry['sys']['id'])
      expect(item.klass).to be_nil
      expect(item.type).to eq("DeletedAsset")
      expect(item.record?).to eq(false)
    end
  end
end
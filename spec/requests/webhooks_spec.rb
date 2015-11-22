require 'spec_helper'

describe "Webhooks" do

  describe "Shine::Posts" do
    it "can create a Shine::Post" do
      create_post = load_request(type: "post", action: "publish")

      expect {
        post "/shine/sync", create_post, { 'Content-Type' => 'application/vnd.contentful.management.v1+json', 'X-Contentful-Topic' => 'ContentManagement.Entry.publish' }
      }.to change(Shine::Post, :count).by(1)
    end

    it "can delete a Shine::Post" do
      delete_post = load_request(type: "post", action: "unpublish")
      create(:post, cid: delete_post['sys']['id'])

      expect {
        post "/shine/sync", delete_post, { 'Content-Type' => 'application/vnd.contentful.management.v1+json', 'X-Contentful-Topic' => 'ContentManagement.Entry.unpublish' }
      }.to change(Shine::Post, :count).by(-1)
    end

    it "can update a post" do
      update_post = load_request(type: "post", action: "publish")
      create(:post, cid: update_post['sys']['id'])

      expect {
        post "/shine/sync", update_post, { 'Content-Type' => 'application/vnd.contentful.management.v1+json', 'X-Contentful-Topic' => 'ContentManagement.Entry.publish' }
      }.to change(Shine::Post, :count).by(0)
      expect(Shine::Post.first.title).to eq(update_post['fields']['title'][Shine.locale])
    end
  end

  describe "Assets" do
    it "can create an Asset" do
      create_asset = load_request(type: "asset", action: "publish")

      expect {
        post "/shine/sync", create_asset.as_json, { 'Content-Type' => 'application/vnd.contentful.management.v1+json', 'X-Contentful-Topic' => 'ContentManagement.Asset.publish' }
      }.to change(Shine::Asset, :count).by(1)
    end

    it "can delete an Asset" do
      delete_asset = load_request(type: "asset", action: "unpublish")
      create(:asset, cid: delete_asset['sys']['id'])

      expect {
        post "/shine/sync", delete_asset, { 'Content-Type' => 'application/vnd.contentful.management.v1+json', 'X-Contentful-Topic' => 'ContentManagement.Asset.unpublish' }
      }.to change(Shine::Asset, :count).by(-1)
    end

    it "can update an Asset" do
      update_asset = load_request(type: "asset", action: "publish")
      create(:asset, cid: update_asset['sys']['id'])

      expect {
        post "/shine/sync", update_asset, { 'Content-Type' => 'application/vnd.contentful.management.v1+json', 'X-Contentful-Topic' => 'ContentManagement.Asset.publish' }
      }.to change(Shine::Asset, :count).by(0)
      expect(Shine::Asset.first.title).to eq(update_asset['fields']['title'][Shine.locale])
    end
  end
end
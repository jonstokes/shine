require 'spec_helper'

describe "Webhooks" do

  describe "Posts" do
    it "can create a Post" do
      create_post = load_request(type: "post", action: "publish")

      expect {
        post "/webhook", create_post, { 'X-Contentful-Topic' => 'ContentManagement.Entry.publish' }
      }.to change(Post, :count).by(1)
    end

    it "can delete a Post" do
      delete_post = load_request(type: "post", action: "unpublish")
      create(:post, cid: delete_post['sys']['id'])

      expect {
        post "/webhook", delete_post, { 'X-Contentful-Topic' => 'ContentManagement.Entry.unpublish' }
      }.to change(Post, :count).by(-1)
    end

    it "can update a post" do
      update_post = load_request(type: "post", action: "publish")
      create(:post, cid: update_post['sys']['id'])

      expect {
        post "/webhook", update_post, { 'X-Contentful-Topic' => 'ContentManagement.Entry.publish' }
      }.to change(Post, :count).by(0)
      expect(Post.first.title).to eq(update_post['fields']['title'][Content.locale])
    end
  end

  describe "Assets" do
    it "can create an Asset" do
      create_asset = load_request(type: "asset", action: "publish")

      expect {
        post "/webhook", create_asset, { 'X-Contentful-Topic' => 'ContentManagement.Asset.publish' }
      }.to change(Asset, :count).by(1)
    end

    it "can delete an Asset" do
      delete_asset = load_request(type: "asset", action: "unpublish")
      create(:asset, cid: delete_asset['sys']['id'])

      expect {
        post "/webhook", delete_asset, { 'X-Contentful-Topic' => 'ContentManagement.Asset.unpublish' }
      }.to change(Asset, :count).by(-1)
    end

    it "can update an Asset" do
      update_asset = load_request(type: "asset", action: "publish")
      create(:asset, cid: update_asset['sys']['id'])

      expect {
        post "/webhook", update_asset, { 'X-Contentful-Topic' => 'ContentManagement.Asset.publish' }
      }.to change(Asset, :count).by(0)
      expect(Asset.first.title).to eq(update_asset['fields']['title'][Content.locale])
    end
  end
end
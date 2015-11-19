require 'spec_helper'

describe UpsertContentItem do
  it "updates an existing entry" do
    item = Content::Item.new load_request(type: "post", action: "publish")
    post = create(:post, cid: item.id )

    expect(post.title).to match(/Title \d/)

    expect {
      UpsertContentItem.call(item: item)
    }.to change(Post, :count).by(0)
    post.reload
    expect(post.title).to eq(item['title'])
  end

  it "creates a new entry" do
    item = Content::Item.new load_request(type: "post", action: "publish")

    expect {
      UpsertContentItem.call(item: item)
    }.to change(Post, :count).by(1)
    expect(Post.first.title).to eq(item['title'])
  end

  it "updates an existing asset" do
    item = Content::Item.new load_request(type: "asset", action: "publish")
    asset = create(:asset, cid: item.id )

    expect(asset.title).to match(/Title \d/)

    expect {
      UpsertContentItem.call(item: item)
    }.to change(Asset, :count).by(0)
    asset.reload
    expect(asset.title).to eq(item['title'])
  end

  it "creates a new asset" do
    item = Content::Item.new load_request(type: "asset", action: "publish")

    expect {
      UpsertContentItem.call(item: item)
    }.to change(Asset, :count).by(1)
    expect(Asset.first.title).to eq(item['title'])
  end
end
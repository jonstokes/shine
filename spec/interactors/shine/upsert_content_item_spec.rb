require 'spec_helper'

describe Shine::UpsertContentItem do
  it "updates an existing entry" do
    item = Shine::Item.new load_request(type: "post", action: "publish")
    post = create(:post, cid: item.id )

    expect(post.title).to match(/Title \d/)

    expect {
      Shine::UpsertContentItem.call(item: item)
    }.to change(Shine::Post, :count).by(0)
    post.reload
    expect(post.title).to eq(item['title'])
  end

  it "creates a new entry" do
    item = Shine::Item.new load_request(type: "post", action: "publish")

    expect {
      Shine::UpsertContentItem.call(item: item)
    }.to change(Shine::Post, :count).by(1)
    expect(Shine::Post.first.title).to eq(item['title'])
  end

  it "updates an existing asset" do
    item = Shine::Item.new load_request(type: "asset", action: "publish")
    asset = create(:asset, cid: item.id )

    expect(asset.title).to match(/Title \d/)

    expect {
      Shine::UpsertContentItem.call(item: item)
    }.to change(Shine::Asset, :count).by(0)
    asset.reload
    expect(asset.title).to eq(item['title'])
  end

  it "creates a new asset" do
    item = Shine::Item.new load_request(type: "asset", action: "publish")

    expect {
      Shine::UpsertContentItem.call(item: item)
    }.to change(Shine::Asset, :count).by(1)
    expect(Shine::Asset.first.title).to eq(item['title'])
  end
end
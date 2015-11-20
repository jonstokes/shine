require 'spec_helper'

describe Shine::DeleteContentItem do
  it "deletes an existing asset" do
    item = Shine::Item.new load_request(type: "asset", action: "unpublish")
    asset = create(:asset, cid: item.id )

    expect {
      Shine::DeleteContentItem.call(item: item)
    }.to change(Shine::Asset, :count).by(-1)
    expect(Shine::Asset.exists?(asset.id)).to eq(false)
  end

  it "deletes an existing entry" do
    item = Shine::Item.new load_request(type: "post", action: "unpublish")
    post = create(:post, cid: item.id )

    expect {
      Shine::DeleteContentItem.call(item: item)
    }.to change(Shine::Post, :count).by(-1)
    expect(Shine::Post.exists?(post.id)).to eq(false)
  end
end
require 'spec_helper'

describe DeleteContentItem do
  it "deletes an existing asset" do
    item = Content::Item.new load_request(type: "asset", action: "unpublish")
    asset = create(:asset, cid: item.id )

    expect {
      DeleteContentItem.call(item: item)
    }.to change(Asset, :count).by(-1)
    expect(Asset.exists?(asset.id)).to eq(false)
  end

  it "deletes an existing entry" do
    item = Content::Item.new load_request(type: "post", action: "unpublish")
    post = create(:post, cid: item.id )

    expect {
      DeleteContentItem.call(item: item)
    }.to change(Post, :count).by(-1)
    expect(Post.exists?(post.id)).to eq(false)
  end
end
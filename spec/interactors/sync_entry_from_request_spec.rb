require 'spec_helper'

describe SyncEntryFromRequest do
  it "updates an existing entry" do
    params = load_source(type: "post", action: "publish")
    post = create(:post, cid: params['sys']['id'] )

    expect(post.title).to match(/Title \d/)

    expect {
      SyncEntryFromRequest.call(params: params)
    }.to change(Post, :count).by(0)
    post.reload
    expect(post.title).to eq(params['fields']['title'][Content.locale])
  end

  it "creates a new entry" do
    params = load_source(type: "post", action: "publish")

    expect {
      SyncEntryFromRequest.call(params: params)
    }.to change(Post, :count).by(1)
    expect(Post.first.title).to eq(params['fields']['title'][Content.locale])
  end
end
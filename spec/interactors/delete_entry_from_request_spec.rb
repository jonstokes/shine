require 'spec_helper'

describe DeleteEntryFromRequest do
  it "deletes an existing entry" do
    params = load_source(type: "post", action: "unpublish")
    post = create(:post, cid: params['sys']['id'] )

    expect {
      DeleteEntryFromRequest.call(params: params)
    }.to change(Post, :count).by(-1)
    expect(Post.exists?(post.id)).to eq(false)
  end
end
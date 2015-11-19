require 'spec_helper'

describe RunSyncSession do
  it "synchronizes the creation of entries and assets" do
    stub_request(:get, Regexp.new(Content.configuration.api_url)).
      to_return(:body => load_sync("all").to_json)

    RunSyncSession.call
    expect(Asset.count).to eq(1)
    expect(Author.count).to eq(1)
    expect(Category.count).to eq(1)
    expect(Post.count).to eq(1)

    expect(Post.first.title).to eq(post.fields[:title])
    expect(Category.first.title).to eq(category.fields[:title])
  end
end
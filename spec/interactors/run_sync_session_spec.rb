require 'spec_helper'

describe RunSyncSession do
  let(:asset) { asset_double }
  let(:author) { author_double }
  let(:category) { category_double }
  let(:post) { post_double }

  it "synchronizes the creation and deletion of entries and assets" do
    Content.delta_list = [
      asset,
      author,
      category,
      post
    ]

    RunSyncSession.call
    expect(Asset.count).to eq(1)
    expect(Author.count).to eq(1)
    expect(Category.count).to eq(1)
    expect(Post.count).to eq(1)

    expect(Post.first.title).to eq(post.fields[:title])
    expect(Category.first.title).to eq(category.fields[:title])

    Content.deletion_list = [
      asset,
      author,
      category,
      post
    ]

    RunSyncSession.call
    expect(Asset.count).to eq(0)
    expect(Author.count).to eq(0)
    expect(Category.count).to eq(0)
    expect(Post.count).to eq(0)
  end
end
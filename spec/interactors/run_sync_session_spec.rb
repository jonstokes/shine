require 'spec_helper'

describe RunSyncSession do
  it "synchronizes the creation of entries and assets" do
    delta_list = load_sync("all")
    stub_request(:get, Regexp.new(Content.configuration.api_url)).
      to_return(:body => delta_list.to_json)

    expect { RunSyncSession.call(mode: "all") }.to change(SyncSession, :count).by(1)

    expect(Asset.count).to eq(6)
    expect(Author.count).to eq(2)
    expect(Category.count).to eq(2)
    expect(Post.count).to eq(3)

    sync_session = SyncSession.first
    expect(sync_session.mode).to eq("all")
    expect(sync_session.status).to eq("success")
  end

  it "synchronizes the deletion of assets" do
    delta_list = load_sync("deletion")
    stub_request(:get, Regexp.new(Content.configuration.api_url)).
      to_return(:body => delta_list.to_json)

    create(:asset, cid: "7BCHkLHgIMuGSg2SqCQyaK")
    create(:category, cid: "4Zk6ihvUM8Y0GcYiY24sq")

    expect {
      RunSyncSession.call(mode: "deletion")
    }.to change(Asset, :count).by(-1)

    expect(Category.count).to eq(0)
    expect(SyncSession.count).to eq(1)
    sync_session = SyncSession.first
    expect(sync_session.mode).to eq("deletion")
    expect(sync_session.status).to eq("success")
  end
end
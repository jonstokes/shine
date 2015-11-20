require 'spec_helper'

describe Shine::RunSyncSession do
  it "synchronizes the creation of entries and assets" do
    delta_list = load_sync("all")
    stub_request(:get, Regexp.new(Shine.configuration.api_url)).
      to_return(:body => delta_list.to_json)

    expect { Shine::RunSyncSession.call(mode: "all") }.to change(Shine::SyncSession, :count).by(1)

    expect(Shine::Asset.count).to eq(6)
    expect(Shine::Author.count).to eq(2)
    expect(Shine::Category.count).to eq(2)
    expect(Shine::Post.count).to eq(3)

    sync_session = Shine::SyncSession.first
    expect(sync_session.mode).to eq("all")
    expect(sync_session.status).to eq("success")
  end

  it "synchronizes the deletion of assets" do
    delta_list = load_sync("deletion")
    stub_request(:get, Regexp.new(Shine.configuration.api_url)).
      to_return(:body => delta_list.to_json)

    create(:asset, cid: "7BCHkLHgIMuGSg2SqCQyaK")
    create(:category, cid: "4Zk6ihvUM8Y0GcYiY24sq")

    expect {
      Shine::RunSyncSession.call(mode: "deletion")
    }.to change(Shine::Asset, :count).by(-1)

    expect(Shine::Category.count).to eq(0)
    expect(Shine::SyncSession.count).to eq(1)
    sync_session = Shine::SyncSession.first
    expect(sync_session.mode).to eq("deletion")
    expect(sync_session.status).to eq("success")
  end
end
require 'spec_helper'

describe SyncAssetFromRequest do
  it "updates an existing asset" do
    params = load_source(type: "asset", action: "publish")
    asset = create(:asset, cid: params['sys']['id'] )

    expect(asset.title).to match(/Title \d/)

    expect {
      SyncAssetFromRequest.call(params: params)
    }.to change(Asset, :count).by(0)
    asset.reload
    expect(asset.title).to eq(params['fields']['title'][Content.locale])
  end

  it "creates a new asset" do
    params = load_source(type: "asset", action: "publish")

    expect {
      SyncAssetFromRequest.call(params: params)
    }.to change(Asset, :count).by(1)
    expect(Asset.first.title).to eq(params['fields']['title'][Content.locale])
  end
end
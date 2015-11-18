require 'spec_helper'

describe DeleteAssetFromRequest do
  it "deletes an existing entry" do
    params = load_source(type: "asset", action: "unpublish")
    asset = create(:asset, cid: params['sys']['id'] )

    expect {
      DeleteAssetFromRequest.call(params: params)
    }.to change(Asset, :count).by(-1)
    expect(Asset.exists?(asset.id)).to eq(false)
  end
end
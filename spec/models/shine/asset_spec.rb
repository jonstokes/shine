require 'spec_helper'

describe Shine::Asset do
  context "validations" do
    subject { create(:asset) }

    it { is_expected.to be_valid }

    it "requires a file" do
      subject.file = {}
      expect(subject).not_to be_valid
    end

    it "requires file to have a valid format" do
      pending "Add a JSON schema validator"
      expect(false).to eq(true)
    end
  end
end
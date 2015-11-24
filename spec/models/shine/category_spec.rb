require 'spec_helper'

describe Shine::Category do
  context "validations" do
    subject { create(:category) }

    it { is_expected.to be_valid }

    it "requires a title" do
      subject.title = nil
      expect(subject).not_to be_valid
    end
  end
end
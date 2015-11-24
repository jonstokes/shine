require 'spec_helper'

describe Shine::User do

  context "validations" do
    subject { create(:user) }

    it { is_expected.to be_valid }

    it "requires an email" do
      subject.email = nil
      expect(subject).not_to be_valid
    end

    it "requires a name" do
      subject.name = nil
      expect(subject).not_to be_valid
    end
  end
end
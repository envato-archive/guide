require 'rails_helper'

RSpec.describe Guide::DefaultAuthenticationSystem do
  let(:authentication_system) { Guide::DefaultAuthenticationSystem.new }

  describe "#user_signed_in?" do
    subject(:user_signed_in?) { authentication_system.user_signed_in? }

    it { is_expected.to be false }
  end

  describe "#url_for_sign_in" do
    subject(:url_for_sign_in) { authentication_system.url_for_sign_in }

    it { is_expected.to be_empty }
  end

  describe "#url_for_sign_out" do
    subject(:url_for_sign_out) { authentication_system.url_for_sign_out }

    it { is_expected.to be_empty }
  end
end

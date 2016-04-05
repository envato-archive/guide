require 'rails_helper'

RSpec.describe Guide::Photographer do
  let(:photographer) { Guide::Photographer.new(image_name, extenstion) }
  let(:image_name) { "my_awesome_image_file" }
  let(:extenstion) { "png" }

  describe "#image_path" do
    subject(:image_path) { photographer.image_path }

    before do
      allow(Rails.application.config.action_controller).to receive(:asset_host).and_return(asset_host)
      allow(ActionController::Base.helpers).to receive(:image_path).
        with("guide/my_awesome_image_file.png").
        and_return("image/with/path/and/digest/my_awesome_image_file.png")
    end
    let(:asset_host) { nil }

    context "when the extension for the image is not specified" do
      let(:extension) { nil }

      it { is_expected.to eq "image/with/path/and/digest/my_awesome_image_file.png" }
    end

    context "when the assets for the Rails app are hosted externally" do
      let(:asset_host) { "external_cdn_for_hosting_assets/" }

      it { is_expected.to eq "external_cdn_for_hosting_assets/image/with/path/and/digest/my_awesome_image_file.png" }
    end

    context "when the Rails app server itself hosts the assets" do
      let(:asset_host) { nil }

      it { is_expected.to eq "image/with/path/and/digest/my_awesome_image_file.png" }
    end
  end
end

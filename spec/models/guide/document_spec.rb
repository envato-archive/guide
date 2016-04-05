require 'rails_helper'

RSpec.describe Guide::Document do
  let(:document) { Guide::Document.new }

  describe "#template" do
    subject(:template) { document.template }

    it { is_expected.to eq "guide/document" }
  end

  describe "#partial" do
    subject(:partial) { document.partial }

    it { is_expected.to be nil }
  end

  describe "#stylesheets" do
    subject(:stylesheets) { document.stylesheets }

    before do
      allow(Guide.configuration).to receive(:default_stylesheets_for_documents).
        and_return("an array of stylesheets")
    end

    it { is_expected.to eq "an array of stylesheets" }
  end

  describe "#javascripts" do
    subject(:javascripts) { document.javascripts }

    before do
      allow(Guide.configuration).to receive(:default_javascripts_for_documents).
        and_return("an array of javascripts")
    end

    it { is_expected.to eq "an array of javascripts" }
  end

  describe "#can_be_rendered?" do
    subject(:can_be_rendered?) { document.can_be_rendered? }

    it { is_expected.to be true }
  end
end

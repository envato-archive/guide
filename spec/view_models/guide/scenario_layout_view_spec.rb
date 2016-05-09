require 'rails_helper'

RSpec.describe Guide::ScenarioLayoutView do
  let(:view_model) do
    described_class.new(
      :node => node_argument,
      :node_title => node_title_argument,
      :scenario => scenario_argument,
      :format => format_argument,
      :injected_html => injected_html_argument,
    )
  end
  let(:node_argument) do
    instance_double(Guide::Structure,
                    :layout_templates => node_layout_templates,
                    :layout_view_model => node_layout_view_model,
                    :stylesheets => ['Node Stylesheets'],
                    :javascripts => ['Node JavaScripts'])
  end
  let(:node_layout_templates) do
    { 'html' => 'html/layout/template' }
  end
  let(:node_layout_view_model) { instance_double(Guide::ViewModel) }

  let(:node_title_argument) { 'Node Title' }
  let(:scenario_argument) { double(:name => 'Scenario Name') }
  let(:format_argument) { 'format' }
  let(:injected_html_argument) { '<h1>Arbitrary Injected HTML</h1>' }

  describe '#node_title' do
    subject(:node_title) { view_model.node_title }

    it "returns the node title that was passed in on initialization" do
      expect(node_title).to eq 'Node Title'
    end
  end

  describe '#scenario_name' do
    subject(:scenario_name) { view_model.scenario_name }

    it "returns the name of the scenario" do
      expect(scenario_name).to eq 'Scenario Name'
    end
  end

  describe '#node_layout_template' do
    subject(:node_layout_template) { view_model.node_layout_template }

    let(:node_layout_templates) do
      {
        'html' => 'html/layout/template',
        'text' => 'text/layout/template',
      }
    end

    context 'there is a node-specific layout template for this format' do
      let(:format_argument) { 'html' }

      it "returns the layout template specified on the node" do
        expect(node_layout_template).to eq 'html/layout/template'
      end
    end

    context 'a node-specific layout template does not exist for this format' do
      let(:format_argument) { 'pdf' }

      it "returns the default layout for scenarios as specified in configuration" do
        expect(node_layout_template).to eq Guide.configuration.default_layout_for_scenarios
      end
    end
  end

  describe '#node_layout_view' do
    subject(:node_layout_view) { view_model.node_layout_view }

    it "returns the layout view model specified on the node" do
      expect(node_layout_view).to eq node_layout_view_model
    end
  end

  describe '#format' do
    subject(:format) { view_model.format }

    it "returns the format that was passed in on initialization" do
      expect(format).to eq 'format'
    end
  end

  describe '#inject_stylesheets?' do
    subject(:inject_stylesheets?) { view_model.inject_stylesheets? }

    context 'the scenario is in HTML format' do
      let(:format_argument) { 'html' }

      it { is_expected.to be true }
    end

    context 'the scenario is in a different format' do
      let(:format_argument) { 'text' }

      it { is_expected.to be false }
    end
  end

  describe '#node_stylesheets' do
    subject(:node_stylesheets) { view_model.node_stylesheets }

    it "returns the stylesheets from the node" do
      expect(node_stylesheets).to eq ['Node Stylesheets']
    end
  end

  describe '#inject_javascripts?' do
    subject(:inject_javascripts?) { view_model.inject_javascripts? }

    context 'the scenario is in HTML format' do
      let(:format_argument) { 'html' }

      it { is_expected.to be true }
    end

    context 'the scenario is in a different format' do
      let(:format_argument) { 'text' }

      it { is_expected.to be false }
    end
  end

  describe '#node_javascripts' do
    subject(:node_javascripts) { view_model.node_javascripts }

    it "returns the javascripts from the node" do
      expect(node_javascripts).to eq ['Node JavaScripts']
    end
  end

  describe '#injected_html' do
    subject(:injected_html) { view_model.injected_html }

    it "returns the HTML injection that was passed in on initialization" do
      expect(injected_html).to eq '<h1>Arbitrary Injected HTML</h1>'
    end
  end
end

require 'rails_helper'

RSpec.describe Guide::EndpointStocktaker do
  let(:stocktaker) { described_class.new(starting_node: starting_node) }

  let(:starting_node) do
    instance_double(Guide::Content,
                    :child_nodes => child_nodes)
  end
  let(:child_nodes) do
    {
      :node => node,
      :structure => structure,
      :document => document,
    }
  end
  let(:node) do
    instance_double(Guide::Node,
                    :can_be_rendered? => false)
  end
  let(:structure) do
    instance_double(Guide::Structure,
                    :can_be_rendered? => true)
  end
  let(:document) do
    instance_double(Guide::Document,
                    :can_be_rendered? => true)
  end

  before do
    allow(Guide::Cartographer).to receive(:new).and_return(cartographer)
  end
  let(:cartographer) do
    instance_double(
      Guide::Cartographer,
      :draw_paths_to_visible_renderable_nodes => paths_to_visible_renderable_nodes
    )
  end
  let(:paths_to_visible_renderable_nodes) do
    {
      "section" => "Section",
      "section/admin" => "Section » Admin",
      "section/friendly/example" => "Section » Friendly » Example",
      "section/friendly/email" => "Section » Friendly » Email",
    }
  end

  before do
    allow(Guide::Monkey).to receive(:new).and_return(monkey)
  end
  let(:monkey) do
    instance_double(Guide::Monkey)
  end
  before do
    allow(monkey).to receive(:fetch_node).with("section").and_return(section)
    allow(monkey).to receive(:fetch_node).with("section/admin").and_return(admin)
    allow(monkey).to receive(:fetch_node).with("section/friendly/example").and_return(example)
    allow(monkey).to receive(:fetch_node).with("section/friendly/email").and_return(email)
  end

  let(:section) do
    instance_double(Guide::Document, :node_type => :document)
  end
  let(:admin) do
    instance_double(Guide::Structure,
                    :node_type => :structure,
                    :formats => [:html],
                    :scenarios => admin_scenarios)
  end
  let(:example) do
    instance_double(Guide::Structure,
                    :node_type => :structure,
                    :formats => [:html],
                    :scenarios => example_scenarios)
  end
  let(:email) do
    instance_double(Guide::Structure,
                    :node_type => :structure,
                    :formats => [:html, :text],
                    :scenarios => email_scenarios)
  end

  let(:admin_scenarios) do
    {
      :default => double,
      :special_case => double,
    }
  end
  let(:example_scenarios) do
    {
      :signed_out => double,
      :less_friendly => double,
      :more_friendly => double,
      :example_scenario_with_really_obnoxiously_long_name_probably_trying_to_describe_something_complicated => double,
    }
  end
  let(:email_scenarios) do
    {
      :default => double,
      :obscure_mail_client => double,
    }
  end

  describe '#to_hash' do
    subject(:to_hash) { stocktaker.to_hash }

    let(:expected_result) do
      {
        "section" => {
          "path" => "/guide/section"
        },
        "section.admin-default-html" => {
          "path" => "/guide/scenario/default/html/for/section/admin"
        },
        "section.admin-special_case-html" => {
          "path" => "/guide/scenario/special_case/html/for/section/admin"
        },
        "section.friendly.example-signed_out-html" => {
          "path" => "/guide/scenario/signed_out/html/for/section/friendly/example"
        },
        "section.friendly.example-less_friendly-html" => {
          "path" => "/guide/scenario/less_friendly/html/for/section/friendly/example"
        },
        "section.friendly.example-more_friendly-html" => {
          "path" => "/guide/scenario/more_friendly/html/for/section/friendly/example"
        },
        "section.friendly.example-example_scenario_with_re..be_something_complicated-html" => {
          "path" => "/guide/scenario/example_scenario_with_really_obnoxiously_long_name_"\
          "probably_trying_to_describe_something_complicated/html/for/section/friendly/example"
        },
        "section.friendly.email-default-html" => {
          "path" => "/guide/scenario/default/html/for/section/friendly/email"
        },
        "section.friendly.email-obscure_mail_client-html" => {
          "path" => "/guide/scenario/obscure_mail_client/html/for/section/friendly/email"
        },
        "section.friendly.email-default-text" => {
          "path" => "/guide/scenario/default/text/for/section/friendly/email"
        },
        "section.friendly.email-obscure_mail_client-text" => {
          "path" => "/guide/scenario/obscure_mail_client/text/for/section/friendly/email"
        },
      }
    end

    it "returns a hash of all of the content that branches from the starting node" do
      is_expected.to eq expected_result
    end
  end
end

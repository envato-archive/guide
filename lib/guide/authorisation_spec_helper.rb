module Guide::AuthorisationSpecHelper
  RSpec.shared_context "the user is allowed to see the active node" do
    before do
      allow(Guide::AuthorisationSystem).to receive(:new).
        and_return(authorisation_system)
      allow(Guide::Bouncer).to receive(:new).
        with(authorisation_system).and_return(bouncer)
      allow(bouncer).to receive(:user_can_access?).
        with(active_node).and_return(true)
    end

    let(:authorisation_system) { double(Guide::AuthorisationSystem) }
    let(:content_node) { Guide::Content.new }
    let(:active_node) do
      Guide::Monkey.new(content_node, bouncer).fetch_node(node_path)
    end
    let(:bouncer) do
      instance_double(Guide::Bouncer,
                      :user_can_access? => true,
                      :user_is_staff? => false)
    end
  end

  RSpec.shared_context "the user is not allowed to see the active node" do
    before do
      allow(Guide::AuthorisationSystem).to receive(:new).
        and_return(authorisation_system)
      allow(Guide::Bouncer).to receive(:new).
        with(authorisation_system).and_return(bouncer)
      allow(bouncer).to receive(:user_can_access?).
        with(active_node).and_return(false)
    end

    let(:authorisation_system) { double(Guide::AuthorisationSystem) }
    let(:content_node) { Guide::Content.new }
    let(:active_node) do
      Guide::Monkey.new(content_node, bouncer).fetch_node(node_path)
    end
    let(:bouncer) do
      instance_double(Guide::Bouncer,
                      :user_can_access? => true,
                      :user_is_staff? => false)
    end
  end

  RSpec.shared_context "the user is allowed to see the scenario" do
    before do
      allow(bouncer).to receive(:user_can_access?).
        with(scenario).and_return(true)
    end

    let(:scenario) { active_node.scenarios[scenario_id] }
  end

  RSpec.shared_context "the user is not allowed to see the scenario" do
    before do
      allow(bouncer).to receive(:user_can_access?).
        with(scenario).and_return(false)
    end

    let(:scenario) { active_node.scenarios[scenario_id] }
  end

  RSpec.shared_context "we are in a development environment" do
    before do
      allow(Rails).to receive(:env).and_return(double(:development? => true))
    end
  end

  RSpec.shared_context "we are not in a development environment" do
    before do
      allow(Rails).to receive(:env).and_return(double(:development? => false))
    end
  end
end

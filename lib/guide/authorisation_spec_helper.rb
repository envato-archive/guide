module Guide::AuthorisationSpecHelper
  RSpec.shared_context "the user is allowed to see the active node" do
    before do
      allow(controller).to receive(:injected_authorisation_system).
        and_return(authorisation_system)
      allow(controller).to receive(:injected_authentication_system).
        and_return(authentication_system)
      allow(Guide::Bouncer).to receive(:new).with(
        authorisation_system: authorisation_system
      ).and_return(bouncer)
      allow(bouncer).to receive(:user_can_access?).
        with(active_node).and_return(true)
    end

    let(:authentication_system) { instance_double(Guide::DefaultAuthenticationSystem) }
    let(:authorisation_system) { instance_double(Guide::DefaultAuthorisationSystem) }
    let(:content_node) { Guide::Content.new }
    let(:active_node) do
      Guide::Monkey.new(content_node, bouncer).fetch_node(node_path)
    end
    let(:bouncer) do
      instance_double(Guide::Bouncer,
                      :user_can_access? => true,
                      :user_is_privileged? => false)
    end
  end

  RSpec.shared_context "the user is not allowed to see the active node" do
    before do
      allow(controller).to receive(:injected_authorisation_system).
        and_return(authorisation_system)
      allow(controller).to receive(:injected_authentication_system).
        and_return(authentication_system)
      allow(Guide::Bouncer).to receive(:new).with(
        authorisation_system: authorisation_system
      ).and_return(bouncer)
      allow(bouncer).to receive(:user_can_access?).
        with(active_node).and_return(false)
    end

    let(:authentication_system) { instance_double(Guide::DefaultAuthenticationSystem) }
    let(:authorisation_system) { instance_double(Guide::DefaultAuthorisationSystem) }
    let(:content_node) { Guide::Content.new }
    let(:active_node) do
      Guide::Monkey.new(content_node, bouncer).fetch_node(node_path)
    end
    let(:bouncer) do
      instance_double(Guide::Bouncer,
                      :user_can_access? => true,
                      :user_is_privileged? => false)
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

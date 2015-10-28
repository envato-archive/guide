module Guide::Authorisation
  RSpec.shared_context "given the bouncer says that the user can see this node" do
    before do
      allow(Guide::Bouncer).to receive(:new).
        with(authorisation_system).and_return(bouncer)
      allow(controller).to receive(:authorisation_system).
        and_return(authorisation_system)
    end

    let(:authorisation_system) do
      double(Guide::AuthorisationSystem).as_null_object
    end
    let(:bouncer) do
      instance_double(Guide::Bouncer,
                      :user_can_access? => true,
                      :user_is_staff? => false)
    end
  end

  RSpec.shared_context "given the bouncer says that the user cannot see this node" do
    before do
      allow(Guide::Bouncer).to receive(:new).
        with(authorisation_system).and_return(bouncer)
      allow(controller).to receive(:authorisation_system).
        and_return(authorisation_system)
    end

    let(:authorisation_system) do
      double(Guide::AuthorisationSystem).as_null_object
    end
    let(:bouncer) do
      instance_double(Guide::Bouncer,
                      :user_can_access? => false,
                      :user_is_staff? => false)
    end
  end

  RSpec.shared_context "given that we are in a development environment" do
    before do
      allow(Rails).to receive(:env).and_return(double(:development? => true))
    end
  end

  RSpec.shared_context "given that we are not in a development environment" do
    before do
      allow(Rails).to receive(:env).and_return(double(:development? => false))
    end
  end
end

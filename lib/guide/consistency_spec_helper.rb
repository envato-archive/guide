module Guide::ConsistencySpecHelper
  RSpec.shared_examples_for "a guide structure and a real view model" do
    described_class.new.scenarios.first.tap do |id, scenario|
      context "\n\n  for scenario #{scenario.name}\n    " do
        let(:guide_view_model) { scenario.view_model }

        it "the Guide::ViewModel implements the real view model's interface\n" do
          expect_implemented_interface(guide_view_model, real_view_model)
        end

        it "the real view model implements the Guide::ViewModel's interface\n" do
          expect_implemented_interface(real_view_model, guide_view_model)
        end
      end
    end
  end

  private

  def expect_implemented_interface(object, interface)
    expect(methods_defined_on(object)).
      to include(*methods_defined_on(interface)),
      "I expected your #{object.class.name} to implement all of the methods on your #{interface.class.name}"
  end

  def methods_defined_on(object)
    if object.kind_of?(Guide::ViewModel)
      object.guide_view_model_interface_methods
    else
      object.methods - Module.instance_methods
    end.sort
  end
end

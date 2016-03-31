module Guide::Consistency
  RSpec.shared_examples_for "a styleguide structure and a real view model" do
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
    expect(accessor_methods_defined_on(object)).
      to include(*accessor_methods_defined_on(interface)),
      "I expected your #{object.class.name} to implement all of the methods on your #{interface.class.name}"
  end

  def accessor_methods_defined_on(object)
    if object.instance_of?(OpenStruct)
      fail "[DEPRECATION] using OpenStruct is deprecated. Please use Guide::ViewModel instead."
    elsif object.instance_of?(Guide::ViewModel) || object.class < Guide::ViewModel
      methods_defined_on_view_model(object)
    else
      methods_defined_on(object)
    end.sort
  end

  def methods_defined_on(object)
    object.methods - Module.instance_methods
  end

  def methods_defined_on_view_model(view_model)
    methods_defined_on(view_model).
      select  { |method| mutator?(method) }.
      collect { |method| matching_accessor(method) }.
      reject  { |method| method == :[] }
  end

  def mutator?(method)
    method.to_s.end_with? '='
  end

  def matching_accessor(method)
    method.to_s.gsub('=', '').to_sym
  end
end

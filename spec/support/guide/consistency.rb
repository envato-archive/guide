module Guide::Consistency
  RSpec.shared_examples_for "a styleguide component and a real presenter" do
    described_class.new.scenarios.first.tap do |id, scenario|
      context "\n\n  for scenario #{scenario.name}\n    " do
        let(:styleguide_presenter) { scenario.presenter }

        it "the Guide::OpenPresenter implements the view model (presenter)'s interface\n" do
          expect_implemented_interface(styleguide_presenter, real_presenter)
        end

        it "the view model (presenter) implements the Guide::OpenPresenter's interface\n" do
          expect_implemented_interface(real_presenter, styleguide_presenter)
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
    if object.instance_of? OpenStruct
      fail "[DEPRECATION] using OpenStruct is deprecated. Please use Guide::OpenPresenter instead."
    elsif object.instance_of?(Guide::OpenPresenter) || object.class < Guide::OpenPresenter
      methods_defined_on_openstruct(object)
    elsif object.respond_to?(:attribute_names)
      methods_defined_on_finerstruct(object)
    else
      methods_defined_on(object)
    end.sort
  end

  def methods_defined_on(object)
    object.methods - Module.instance_methods
  end

  def methods_defined_on_openstruct(openstruct)
    methods_defined_on(openstruct)
    .select  { |method| mutator?(method) } # why do our presenters have mutators??
    .collect { |method| matching_accessor(method) }
    .reject  { |method| method == :[] } # ruby 2.x defines a `[]` accessor and mutator method on OpenStruct. Ignore it.
  end

  def methods_defined_on_finerstruct(finerstruct)
    finerstruct.attribute_names
  end

  def mutator?(method)
    method.to_s.end_with? '='
  end

  def matching_accessor(method)
    method.to_s.gsub('=', '').to_sym
  end
end

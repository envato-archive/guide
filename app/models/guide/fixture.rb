class Guide::Fixture
  # Fixtures are used to generate content for your Living Guide
  # that would otherwise be repetitive, such as view models that are used
  # from multiple components. Declaring these in a single place is useful
  # because it helps keep a consistent interface between the fake view models
  # in the Living Guide and the real view models in your application.
  #
  # Feel free to override or redeclare this class if you want.
  # Nothing in the Guide gem depends on it.
  private

  def self.image_path(image_name, extension)
    Guide::Photographer.new(image_name, extension).image_path
  end
end

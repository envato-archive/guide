class Guide::Fixture

  private

  def self.image_path(image_name, extension)
    Guide::Photographer.new(image_name, extension).image_path
  end
end

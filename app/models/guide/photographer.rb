class Guide::Photographer
  def initialize(image_name, extension = 'png')
    @image_name = image_name
    @extension = extension
  end

  def image_path
    "#{asset_host}#{image_with_path_and_digest}"
  end

  private

  def image_with_path_and_digest
    ActionController::Base.helpers.image_path "guide/#{@image_name}.#{@extension}"
  end

  def asset_host
    Rails.application.config.action_controller.asset_host || ""
  end
end

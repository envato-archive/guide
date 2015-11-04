class Guide::ComponentGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def generate_component
    template "component.rb.erb", "app/styleguide/#{file_path}.rb"
  end

  private

  def full_class_name
    "Guide::Content::#{class_name}"
  end
end

class Guide::Bouncer
  def initialize(authorisation_system:)
    @authorisation_system = authorisation_system
  end

  def user_can_access?(node)
    visibile_to_user?(node.id, node.options[:visibility])
  end

  def user_is_privileged?
    @authorisation_system.user_is_privileged?
  end

  private

  def visibile_to_user?(label, visibility)
    return true if visibility.blank?

    if valid_visibility_options.include?(visibility)
      @authorisation_system.allow?(:"view_guide_#{visibility}")
    else
      raise Guide::Errors::InvalidVisibilityOption, <<-EOS.gsub(' ,', ' nil,').squish
        You tried to give :#{label} a visibility of :#{visibility},
        but :#{visibility} is not a valid selection.
        Valid visibility options include:
        #{valid_visibility_options.join(', :')}.
      EOS
    end
  end

  def valid_visibility_options
    @authorisation_system.valid_visibility_options
  end
end

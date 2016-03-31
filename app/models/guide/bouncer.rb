class Guide::Bouncer
  def initialize(authorisation_system)
    @authorisation_system = authorisation_system
  end

  def user_can_access?(node)
    visibile_to_user?(node.id, node.options[:visibility])
  end

  def user_is_staff?
    @authorisation_system.allow?(:view_guide_unpublished) ||
      @authorisation_system.allow?(:view_guide_restricted)
  end

  def user_signed_in?
    @authorisation_system.user_signed_in?
  end

  private

  def visibile_to_user?(label, visibility)
    return true unless visibility
    if Guide.configuration.access_level_keys.include?(visibility)
      @authorisation_system.allow?(:"view_guide_#{visibility}")
    else
      raise Guide::Errors::InvalidVisibilityLevel, <<-EOS.gsub(' ,', ' nil,').squish
        You tried to give :#{label} a visibility of :#{visibility},
        but :#{visibility} is not a valid selection.
        Valid visibility options include:
        #{valid_visibility_levels.join(', :')}.
      EOS
    end
  end

  def valid_visibility_levels
    # Feel free to override this method in your application if you would like
    # a different set of visibility levels. Starting with nil is recommended.
    [
      nil,
      :unpublished,
      :restricted,
    ]
  end
end

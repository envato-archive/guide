class Guide::DefaultAuthorisationSystem
  def allow?(action)
    true
  end

  def user_is_privileged?
    allow?(:view_guide_unpublished) ||
      allow?(:view_guide_restricted)
  end

  def valid_visibility_options
    [
      nil,
      :unpublished,
      :restricted,
    ]
  end
end

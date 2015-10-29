class Guide::AuthorisationSystem
  def initialize(user: nil)
    @user = user
  end

  def allow?(action)
    return true if bypass_authorisation?

    system.allow?(action)
  end

  private

  def system
    # Override this method with code that makes sense in the context
    # of your application. If you don't care about authorisation,
    # feel free to leave this blank.
  end

  def bypass_authorisation?
    # By default, Guide will allow anything in development.
    # If you don't override the system method, everything is allowed.
    Rails.env.development? || system.blank?
  end
end

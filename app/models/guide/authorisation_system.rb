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
    Guide.configuration.authorisation_system_class.constantize.new(@user)
  end

  def bypass_authorisation?
    Rails.env.development?
  end

  class Default
    def initialize(_user)
    end

    def allow?(action)
      true
    end
  end
end

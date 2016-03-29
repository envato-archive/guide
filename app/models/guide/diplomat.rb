class Guide::Diplomat
  def initialize(session, params, default_locale)
    @session = session
    @params = params
    @default_locale = default_locale
  end

  def negotiate_locale
    store_new_locale_in_session if supported_locales.has_value? new_locale

    best_locale
  end

  def supported_locales
    Guide.configuration.supported_locales
  end

  def multiple_supported_locales?
    supported_locales.keys.size > 1
  end

  def current_locale
    if supported_locales.has_value? locale_from_session
      locale_from_session
    else
      clear_locale_from_session
      @default_locale
    end
  end

  private

  def best_locale
    if supported_locales.has_value? temporary_locale
      temporary_locale
    else
      current_locale
    end
  end

  def new_locale
    @params[:locale]
  end

  def temporary_locale
    @params[:temp_locale]
  end

  def locale_from_session
    @session[:guide_locale]
  end

  def store_new_locale_in_session
    @session[:guide_locale] = new_locale
  end

  def clear_locale_from_session
    @session.delete(:guide_locale)
  end
end

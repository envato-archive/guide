class Guide::DefaultAuthenticationSystem
  def user_signed_in?
    false
  end

  def url_for_sign_in
    ''
  end

  def url_for_sign_out
    ''
  end
end

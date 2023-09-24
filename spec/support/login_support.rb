module LoginSupport
  def logged_in?
    !session[:user_id].nil?
  end

  def login(user)
    post login_path, params: { session: { email: user.email, password: user.password } }
  end
end
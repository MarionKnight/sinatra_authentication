helpers do

  def current_user
    # TODO: return the current user if there is a user signed in.
    # Stealing some thunder... 
    return nil unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end

end

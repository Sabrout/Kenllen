module SessionsHelper

def log_in(user)
session[:user_id] = user.user_id
end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(user_id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(user_id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

def logged_in?
 !current_user.nil?
end

def log_out
forget(current_user)
session.delete(:user_id)
@current_user = nil
end

def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.user_id
    cookies.permanent[:remember_token] = user.remember_token
end

def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
end

end

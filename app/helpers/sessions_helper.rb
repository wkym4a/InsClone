module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  #ログインしている（＝current_userに値が入っている）ならT、いないならFを返す
  def logged_in?
    current_user.present?
  end
end

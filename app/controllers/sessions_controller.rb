class SessionsController < ApplicationController

def new
  @pictures = Picture.all.order(id: "DESC")

end

def create
  user=User.find_by(email: params[:session][:email].downcase)

  #メールアドレスに対応するユーザーがない場合はエラーを出して抜ける
  if user==nil
    flash[:danger] = 'メールアドレスが不正です。'
    render 'new'

  elsif user.authenticate(params[:session][:password])==false
    #パスワードが違う場合はエラーにして抜ける
    flash[:danger] = 'パスワードが間違っています。'
    render 'new'
  else
    #パスワードが合っていた場合→ユーザーのidを保存→ログイン
    session[:user_id]=user.id
    redirect_to user_path(current_user) , notice: "ログインしました"

  end

end

#ログアウト時処理
def destroy
    session.delete(:user_id)

    redirect_to new_session_path , notice: "ログアウトしました"

end

end

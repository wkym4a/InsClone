class UsersController < ApplicationController
  #事前の権限チェック
  before_action :chk_authorioty_with_id, only: [:show ,:edit, :edit_password ,
                                              :update, :update_password]

  before_action :set_user, only: [:show, :show_aftercreate, :edit, :edit_password,
                                  :update,:update_password]
  def index
    @users = User.all
  end

  def show
  end
  def show_aftercreate
  end

  def new
    @user = User.new
  end

  def edit
  end
  def edit_password
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save(context: :have_pass)
        format.html { redirect_to show_aftercreate_user_path(@user.id),
           notice: '新しいユーザー情報を登録しました。' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params_update)
        format.html { redirect_to @user, notice: 'ユーザー情報を更新しました。' }
      else
        format.html { render :edit }
      end
    end
  end

  def update_password
    respond_to do |format|
      @user.attributes=(user_params_password)
      if @user.save(context: :have_pass)
        format.html { redirect_to @user, notice: 'パスワードを変更しました。' }
      else
        format.html { render :edit_password }
      end
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :photo,:remove_photo,
                                   :pass_hint, :password, :password_confirmation)
    end

    def user_params_update
      #「通常更新」前の画面データ取得→パスワードは変更しない
      param_info = params.require(:user).permit(:name, :email,:remove_photo, :pass_hint)

      if  params[:user][:remove_photo]=="1"
        #「写真を削除する」場合→「nil」を設定する
        param_info[:photo]= nil
        param_info[:photo_cache]= nil
      elsif not (user_params[:photo]==nil )
        #新たな写真情報が設定されていた場合→その情報をセットする
        param_info[:photo]= user_params[:photo]
        param_info[:photo_cache]= user_params[:photo_cache]

        #どちらでもない場合→更新前の画像情報(set_userで取得した値)をそのまま維持する
      end
      return param_info
    end

    def user_params_password
      #「パスワード更新」前の画面データ取得→パスワードのみ変更する
      params.require(:user).permit(:password, :password_confirmation)
    end

    #処理前の権限チェック
    #変更対象投稿の作成ユーザーと同じかどうかもチェック……お気に入り削除処理
    def chk_authorioty_with_id
      if have_authorioty?(params[:id]) ==false
        redirect_to no_authority_path
      end
    end
end

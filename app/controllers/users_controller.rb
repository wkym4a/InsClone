class UsersController < ApplicationController
  before_action :set_user, only: [:show, :show_aftercreate, :edit, :edit_password,
                                  :update,:update_password,  :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end
  def show_aftercreate
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
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
      #if @user.update(user_params_password)context: :have_pass)

        format.html { redirect_to @user, notice: 'パスワードを変更しました。' }
      else
        format.html { render :edit_password }
      end
    end

  end

  # # DELETE /users/1 ユーザー情報は削除しない
  # # DELETE /users/1.json
  # def destroy
  #   @user.destroy
  #   respond_to do |format|
  #     format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
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
end

class FavoritesController < ApplicationController
  before_action :chk_authorioty_no_id, only: [:create]
  before_action :chk_authorioty_with_id, only: [:destroy]

  #登録処理
  def create
    @favorite = Favorite.new(picture_id: params[:format] , user_id: current_user.id)

    if @favorite.save
      redirect_to request.referrer , notice: 'お気に入り登録に成功しました。'
    else
      redirect_to request.referrer , notice: 'お気に入り登録に失敗しました。'
    end
  end

  #削除処理
  def destroy
    @favorite = Favorite.where(picture_id: params[:id] , user_id: current_user.id)

      if @favorite.delete_all
        redirect_to request.referrer ,  notice: 'お気に入りの削除に成功しました。'
      else
        redirect_to request.referrer ,  notice: 'お気に入りに失敗しました。'
      end
  end

  #処理前の権限チェック
  #ログインしているかどうかだけチェック……お気に入り登録処理
  def chk_authorioty_no_id
    if have_authorioty? ==false
      redirect_to no_authority_path
    end
  end
  #変更対象投稿の作成ユーザーと同じかどうかもチェック……お気に入り削除処理
  def chk_authorioty_with_id
    if have_authorioty?(Picture.find(params[:id]).user_id) ==false
      redirect_to no_authority_path
    end
  end
end

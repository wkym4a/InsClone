class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :edit_confirm ,:update, :destroy]

  def index
    @pictures = Picture.all.order(id: "DESC")
  end

  def show
  end

  #「_form」をもとにした画面を開く
  #新規画面表示
  def new

    if  params[:back]
      @picture=Picture.new(picture_params)
    else
      @picture=Picture.new
    end

  end

  #更新画面
  def edit

    if  params[:back]
        #「バリデーションに引っかかって戻る」場合、それまでの画面情報を変数に格納
        reset_picture
    end

  end

  #「_confirm_form」をもとにした画面を開く
  #新規登録前の確認画面
  def confirm
    @picture = Picture.new(picture_params)
    @picture.user_id=current_user.id

    if @picture.invalid?
      params[:validate_err]=:on
      render 'new'

    end
  end

  #更新登録前の確認画面
  def edit_confirm
    #更新画面で変更した（かもしれない）内容を、変数に格納
    reset_picture

    if @picture.invalid?
      params[:validate_err]=:on
      render 'new'
    end

  end

  #データ登録処理
  #新規登録
  def create
    @picture = Picture.new(picture_params)
    @picture.user_id=current_user.id

    binding.pry
    respond_to do |format|
      if @picture.save

        #新規投稿した旨のメールを送る
        PostedMailer.posted_mail_new(@picture).deliver

        format.html{redirect_to pictures_path , notice: '登録に成功しました。' }
      else
        format.html{redirect_to new_picture_path , notice: '登録に失敗しました。' }
      end
    end
  end

  #更新処理
  def update

    respond_to do |format|

      #_oldには更新前の値を保持させたいので、
      #「dup」をつけて値を渡すことで「@picture」との連動を切断する（別のインスタンスを作成する）
      picture_old = @picture.dup

          binding.pry
      if @picture.update(picture_params)==true

        #投稿編集した旨のメールを送る
        PostedMailer.posted_mail_edit(@picture,picture_old).deliver

        format.html{redirect_to pictures_path , notice: '更新に成功しました。' }
      else
        format.html{redirect_to picture_path(@picture.id) , notice: '更新に失敗しました。' }
      end

    end

  end

  #削除処理
  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to pictures_path, notice: '投稿を削除しました。' }

      #投稿削除した旨のメールを送る
      PostedMailer.posted_mail_delete(@picture).deliver
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_picture
    @picture = Picture.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def picture_params

    params.require(:picture).permit(:title, :content, :image, :image_cache,:remove_image)
  end

  #アクション前に表示していた内容を、モデル型変数にセットし直す
  def reset_picture
    @picture.title= picture_params[:title]
    @picture.content= picture_params[:content]

    if not (picture_params[:image]==nil )

      @picture.image= picture_params[:image]
      @picture.image_cache = picture_params[:image_cache]
    end

  end

end

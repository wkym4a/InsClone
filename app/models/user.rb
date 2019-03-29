class User < ApplicationRecord
  has_secure_password

  #入力制限確認前の処理
  #メールアドレスはすべて小文字に変換する
  before_validation {email.downcase!}

  #入力制限
  validates :name, presence: true , length: {maximum:40}


  validates :email, presence: true,uniqueness: true ,
             length: { maximum: 255 },
             format:{with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  validates :pass_hint,length: {maximum:40}

  validates :password_digest , presence: true

  #パスワードのバリデーションチェックは「have_pass」時のみ
  #……【通常の（パスワード以外を変更する）プロフィール更新ではチェックしない
  validates :password ,presence: true , length: {minimum: 2 , maxumum: 40} , on: :have_pass

  #「photo」には画像を保存
  mount_uploader :photo,PhotoUploader

  has_many :pictures , dependent: :destroy

  has_many :favorites , dependent: :destroy
  has_many :favorite_pictures , through: :favorites , source: :picture
end

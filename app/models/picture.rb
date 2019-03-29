class Picture < ApplicationRecord

    #入力制限
    validates :title, presence: true , length: { maximum: 40 }
    validates :content, length: { maximum: 140 }


    #「photo」には画像を保存
    mount_uploader :image,ImageUploader

    belongs_to :user

    has_many :favorites , dependent: :destroy
    has_many :favorite_users , through: :favorites , source: :user
end

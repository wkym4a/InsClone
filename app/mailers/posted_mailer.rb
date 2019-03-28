class PostedMailer < ApplicationMailer

def posted_mail_new(picture)
  @picture = picture

  mail to: @picture.user.email , subject:"新規投稿の確認メール"
end


def posted_mail_edit(picture,picture_old)

  @picture = picture
  @picture_old = picture_old
binding.pry
  mail to: @picture.user.email , subject:"投稿編集の確認メール"
end

def posted_mail_delete(picture)
  @picture = picture

  mail to: @picture.user.email , subject:"投稿削除の確認メール"
end

end

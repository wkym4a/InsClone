class PostedMailer < ApplicationMailer
  def posted_mail_new(picture)
    @picture = picture
    mail to: @picture.user.email.to_s , subject:"新規投稿の確認メール"
  end

  def posted_mail_edit(picture,picture_old)
    @picture = picture
    @picture_old = picture_old
    mail to: @picture.user.email.to_s , subject:"投稿編集の確認メール"
  end

  def posted_mail_delete(picture)
    @picture = picture
    mail to: @picture.user.email.to_s.to_s , subject:"投稿削除の確認メール"
  end
end

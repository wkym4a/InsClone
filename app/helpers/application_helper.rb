module ApplicationHelper
  #モデル（あるいはそれが格納された変数（特にインスタンス変数を想定））の情報をもとに、
  #そのもととなる情報の日本語名を返す……エラーメッセージ表示などでの使用を想定
  def get_tablename_by_model(model_info)

    case model_info.model_name.name
      when "User"
        return "ユーザー"

      when "Picture"
        return "投稿"
      else
        return "「get_tablename_by_model」で想定されていない種類のテーブル"
    end

  end

  #権限の有無をチェック
  #……画面のボタン表示判断やボタンを押した後の画面表示可否判断に使用する。
  def have_authorioty?(changeinfo_userid = nil)

    if logged_in? == false
      #そもそもログインしていなければ、F
      return false

    else

      #変更する情報の「ユーザーid」を持っていない場合→Tを返す
      #(この場合、ログインしているかどうかだけを判断)
      if changeinfo_userid == nil
        return true
      else

        #自分（＝ログインしるユーザー）のidが変更情報のidと一致すればT、異なればFを返す
        if current_user.id.to_s == changeinfo_userid.to_s
          return true
        else
          return false
        end
      end
    end
  end

  #【削除後、元の画面（削除情報も乗っていた一覧画面、など）を表示する】などの処理で使用予定。
  #→「request.referrer」だけで処理できそうなので、とりあえず無効化。
  #万が一必要になる場合も考慮し、念の為残しておく。
  # def get_return_url
  #
  #   refer_info = Rails.application.routes.recognize_path(request.referrer)
  #
  #   if refer_info[:id]=nil
  #     id_info=""
  #   else
  #     id_info="/" + refer_info[:id]
  #   end
  #
  #   return "/" + refer_info[:controller] + id_info + "/" + refer_info[:action]
  #
  # end

end

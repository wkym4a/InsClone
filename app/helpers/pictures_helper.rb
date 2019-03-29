module PicturesHelper
  def get_next_url_picture(id_info,next_btn=true)
    #「next_btn」がFの場合→戻るボタンを押した場合の
    #【①：url、②HTTPメソッド（文字列情報）】を取得する
    if params[:validate_err] ==nil
      #「validate_err」でない→通常に画面を開いた場合
      case action_name
        when 'new'#新規画面を開いたなら
          if next_btn==true
            #次のアクションは「新規登録前確認画面の表示」
            return [confirm_pictures_path,"post"]
          #新規画面、「戻る」ボタン無し

          end
        when 'confirm'
          #新規登録前画面を開いたなら
          if next_btn==true
          #次のアクションは「新規登録処理」
            return [pictures_path,"post"]
          else
            #戻るアクションは「新規登録画面の表示」
            return [new_picture_path,"get"]
          end
        when 'show'#閲覧画面を開いたなら
          if next_btn==true
            #次のアクションは「更新画面の表示」
              return [edit_picture_path(id_info),"get"]
          #新規画面、「戻る」ボタン無し

          end
        when 'edit'#更新画面を開いたなら
          if next_btn==true
            #次のアクションは「更新前確認画面の表示」
            return [edit_confirm_picture_path(id_info),"post"]
          else
          #「更新」画面、「戻る」ボタン無し

          end
        when 'edit_confirm'#更新前画面を開いたなら
          if next_btn==true
            #次のアクションは「更新処理」……メソットがpatch
            return [picture_path(id_info),"patch"]
          else
            #戻るアクションは「更新画面の表示」
            return [edit_picture_path(id_info),"get"]
          end

        else#取得できなかった場合、一覧に戻る（発生しないと思うが念の為
          return [pictures_path,"get"]
        end
    else
      #バリデーションエラーによって戻った場合
      case action_name
        when 'confirm'#「confirm」でバリd−ションエラー→新規画面を開いたなら
          if next_btn==true
            #次のアクションは「新規登録前確認画面の表示」
            return [confirm_pictures_path,"post"]
            #戻るアクションは無し

          end
        when 'create'#「create」でバリd−ションエラー→新規登録前画面を開いたなら
          if next_btn==true
            #次のアクションは「新規登録処理」……メソットがpost
            return [pictures_path,"post"]
          else
            #戻るアクションは新規登録画面の表示」
            return [new_picture_path,"get"]
          end
        #when 'edit'……更新画面遷移時にバリデーションが発生することはない。
        when 'edit_confirm'#「edit_confirm」でバリd−ションエラー→更新画面を開いたなら
          if next_btn==true
            #次のアクションは「更新前確認画面の表示」
            return [edit_confirm_picture_path(id_info),"post"]
            #戻るアクションは無し

          end
        when 'update'#「update」でバリd−ションエラー→更新前画面を開いたなら
          if next_btn==true
            #次のアクションは「更新処理」……メソットがpatch
            return [picture_path(id_info),"patch"]
          else
            #戻るアクションは新規登録前確認画面の表示」
            return [edit_picture_path(id_info),"get"]
          end
        else#取得できなかった場合、一覧に戻る（発生しないと思うが念の為
            return [pictures_path,"get"]
        end
    end
  end
end

# sever端 的 連線設定

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    # https://guides.rubyonrails.org/action_cable_overview.html#connections
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private
      def find_verified_user
        # if verified_user = User.find_by(id: cookies.encrypted[:user_id])
        if verified_user = env['warden'].user # devise給的環境變數 直接取得使用者（如果有登入的話） 
        # 指定env['warden'].user值 給 verified_user ，在ruby中 被指定了什麼值 回傳值 就會是 那個值，所以有值就會執行這條
          verified_user
        else # 沒登入的話
          reject_unauthorized_connection
        end
      end
  end
end

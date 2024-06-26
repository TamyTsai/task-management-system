# $ rails g channel board

class BoardChannel < ApplicationCable::Channel
  def subscribed
    stream_from "board"
    # 一般網頁 每個使用者有多個聊天室 所以通常後面會有編號
    # 要監聽這裡的事件 就要 訂閱 這個 stream board
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end

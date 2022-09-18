class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel_#{params['room_id']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    # Message.create! content: data['message'], customer_id: current_customer.id, room_id: params['room']
    # ActionCable.server.broadcast "room_channel_#{params['room_id']}", message: render_message(data)
    # Message.create! content: data['message']

    # Messageにデータを保存
    Message.create(
      customer_id: current_customer.id,
      room_id: params['room_id'],
      content: data['message']
    )

    # 部分テンプレートをWebSocket経由で送り出す。
    #   render_messageで部分テンプレートに文字を埋め込みmessageとして送り出している。
    ActionCable.server.broadcast("room_channel_#{params['room_id']}", { message: render_message(data) })
  end

  private

  def render_message(data)
    renderer = ApplicationController.renderer.new(
      http_host: ENV['HOST_URL'],
      https: ENV['HTTPS']
      )
    return renderer.render(
      partial: 'public/messages/message',
      locals: { message: data, current_customer: current_customer }
    )
  end
end

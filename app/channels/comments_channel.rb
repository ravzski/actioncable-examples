class CommentsChannel < ApplicationCable::Channel

  #
  # these methods are called from the javascript through websocket
  #


  # stop_all_streams - tells redis to stop listening to all channels
  # stream_from - tells redis to listen to this specific channel

  # this method triggers when a user access a channel
  def follow(data)
    stop_all_streams
    stream_from "messages:#{data['message_id'].to_i}:comments"
  end

  def unfollow
    stop_all_streams
  end
end

class CommentRelayJob < ApplicationJob

  #
  # ActionCable.server.broadcast - tells the server to render html/json to this
  # "messages:#{comment.message_id}:comments" channel
  #
  def perform(comment)
    ActionCable.server.broadcast "messages:#{comment.message_id}:comments",
      comment: CommentsController.render(partial: 'comments/comment', locals: { comment: comment })
  end
end

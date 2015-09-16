# joins the comments channel
# NOTE: CommentsChannel connections to channels/comments_channel.rb
App.comments = App.cable.subscriptions.create "CommentsChannel",

  #lists all comments on this channel
  collection: -> $("[data-channel='comments']")

  #
  # triggers when a client successfully connects to this channel
  #
  connected: ->
    setTimeout =>
      @followCurrentMessage()
      @installPageChangeCallback()
    , 1000

  #
  # triggers when a client successfully receives a message
  #
  received: (data) ->
    @collection().append(data.comment) unless @userIsCurrentUser(data.comment)

  #
  # validates if the user is the current user
  #
  userIsCurrentUser: (comment) ->
    $(comment).attr('data-user-id') is $('meta[name=current-user]').attr('id')

  #
  # @perform - calls the follow method on channels/comments_channel.rb
  #
  followCurrentMessage: ->
    if messageId = @collection().data('message-id')
      @perform 'follow', message_id: messageId
    else
      @perform 'unfollow'

  #
  # $(document).on 'page:change' is specific to turbolinks
  #
  installPageChangeCallback: ->
    unless @installedPageChangeCallback
      @installedPageChangeCallback = true
      $(document).on 'page:change', -> App.comments.followCurrentMessage()

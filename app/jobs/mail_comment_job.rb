class MailCommentJob < ApplicationJob
  queue_as :default

  def perform(comment_id)
    # Do something later
    #pass id as parameter
    comment=Comment.find(comment_id)
    CommentMailer.submission(comment).deliver
  end
end

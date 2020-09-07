class MailCommentJob < ApplicationJob
  queue_as :default

  def perform(comment)
    # Do something later
    CommentMailer.submission(comment).deliver
  end
end

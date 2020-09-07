class CommentMailer < ApplicationMailer
    def submission(comment)
        @comment = comment
        @from_user=comment.user.name
        mail(to: comment.blog.user.email, subject: "#{@from_user} commented on your blog")
    end
end

module ApplicationHelper
    def is_accessible(user)
        return true if user_signed_in? && (current_user.admin||current_user.id==user.id)
        false
    end
end

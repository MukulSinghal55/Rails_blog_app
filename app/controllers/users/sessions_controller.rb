class Users::SessionsController < Devise::SessionsController
    def destroy
      current_user.invalidate_all_sessions!
      super
    end
  end
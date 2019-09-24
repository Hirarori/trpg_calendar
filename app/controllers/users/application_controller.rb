class Users::ApplicationController  < ApplicationController
  before_action :authenticate_user!
  # ログイン後、blogs/indexに移動する
  def after_sign_in_path_for(resource)
    user_path(current_user)
  end
end
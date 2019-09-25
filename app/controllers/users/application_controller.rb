class Users::ApplicationController  < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
    @plans = @user.plans.paginate(page: params[:page])
  end
end
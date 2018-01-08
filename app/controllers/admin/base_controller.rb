class Admin::BaseController < ActionController::Base

  layout 'admin/layouts/admin'

  before_action :auth_admin

  private
  def auth_admin
    unless logged_in? 
      flash[:notice] = "请登录"
      redirect_to new_session_path
    end
  end
end

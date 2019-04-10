class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # ログイン後、ログアウト後のリダイレクト先指定
  def after_sign_in_path_for(resource)
    if current_user.admin?
      admin_top_path
    else
      events_path
    end
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end
  
  private
  #ユーザー認証
    def authenticate_admin
      unless current_user.admin?
        redirect_to events_path
      end
    end

    def correct_user
      user = User.find_by(id: params[:id])
      unless current_user.id == user.id || current_user.admin?
        redirect_to events_path
      end
    end
  # user_nameカラム追加設定
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name])
  end
end

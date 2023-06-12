class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :friends_and_myself

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name username age interest profile_picture email])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name username age interest profile_picture email])
  end
end

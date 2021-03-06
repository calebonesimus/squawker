class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :authenticate_user!
  before_action :new_squawk

  protected

  # Create a new squawk for every page
  # So that a user can always create a new squawk
  def new_squawk
    @new_squawk = Squawk.new
  end

  # Sets up whitelist for devise attributes across
  # all authentication points
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) do |u|
      u.permit(:username,
               :email,
               :password,
               :remember_me)


    end

    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:username,
               :email,
               :first_name,
               :last_name,
               :avatar,
               :password,
               :password_confirmation)
    end

    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:username,
               :email,
               :username,
               :first_name,
               :last_name,
               :bio,
               :private,
               :avatar,
               :current_password)
    end
  end

end

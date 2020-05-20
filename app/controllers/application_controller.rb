class ApplicationController < ActionController::Base
  def is_admin
    unless current_user.has_role? :admin
      redirect_back fallback_location: root_path
    end
  end
end

class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    flash[:notice] = "Привет, #{current_user.first_name}!"
    if resource.is_a?(Admin)
      admin_tests_path
    else 
      super
    end
  end
end

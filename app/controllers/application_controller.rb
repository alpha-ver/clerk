class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def redirect_to_dash
    redirect_to dashboard_path
  end

  private

    def cat_main(category)
      if category.parent.name == 'root'
        category.id
      else
        cat_main(category.parent)
      end
    end

    def admin
      redirect_to "/" if current_user.nil? || !current_user.admin
    end
end

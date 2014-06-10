class DashboardController < ApplicationController
  before_filter :authenticate_user!
  before_filter :admin
  
  def index
    @category  = Category.root
    @templates = current_user.templates
    @fields    = Field.all
  end

  def category

  end

end

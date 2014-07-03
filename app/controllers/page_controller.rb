class PageController < ApplicationController
  def index
    @category = Category.root
  end
end

class Category < ActiveRecord::Base
  belongs_to :parent
  has_many   :childs, :as => :parent
end

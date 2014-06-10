class Template < ActiveRecord::Base

  belongs_to :user
  has_many   :template_fields
  
end

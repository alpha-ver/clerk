class TemplateField < ActiveRecord::Base
  
  belongs_to :template
  belongs_to :field
  
end

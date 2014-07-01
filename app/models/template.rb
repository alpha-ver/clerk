class Template < ActiveRecord::Base

  belongs_to :user
  has_many   :template_fields, dependent: :destroy


  validates :name,  :presence => true, 
                    :length => {:minimum => 3, :maximum => 254}
  
end

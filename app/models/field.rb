class Field < ActiveRecord::Base

  has_many :template_fields, dependent: :destroy


  validates :name,  :presence => true, 
                    :length => {:minimum => 3, :maximum => 128}

  validates :code,  :presence => true, 
                    :length => {:minimum => 4, :maximum => 50}

end

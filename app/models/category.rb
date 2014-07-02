class Category < ActiveRecord::Base
  has_many   :children,   class_name: "Category", foreign_key: "parent_id", dependent: :destroy
  belongs_to :parent,     class_name: "Category"

  has_many :documents,   dependent: :destroy
  has_many :permissions, dependent: :destroy 

  scope :root, -> { find_by(:parent_id => -1) }
end

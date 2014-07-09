class Document < ActiveRecord::Base
  belongs_to :category

  has_many :faqs, dependent: :destroy
end

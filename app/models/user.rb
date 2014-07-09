class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :templates,   dependent: :destroy
  has_many :permissions, dependent: :destroy
  has_many :faqs,        dependent: :destroy

end

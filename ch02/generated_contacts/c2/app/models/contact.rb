class Contact < ActiveRecord::Base
  belongs_to :user
  belongs_to :company
  has_one :address
  has_many :tasks
end

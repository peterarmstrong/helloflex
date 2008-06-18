class Company < ActiveRecord::Base
  has_one :address
  has_many :contacts
end

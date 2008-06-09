class User < ActiveRecord::Base
  has_one :contact
  has_many :tasks
  has_many :contacts
  has_many :messages
end

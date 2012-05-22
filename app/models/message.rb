class Message < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user
  validates_presence_of :text, :allow_blank => false
end

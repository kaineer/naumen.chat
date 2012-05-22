class Message < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user
  validates_presence_of :text, :allow_blank => false

  scope :recent, includes(:user).order("created_at DESC").limit(20)
  scope :sent_after, lambda { |time|
    includes(:user).order("created_at DESC").where(["created_at >= ?", time])
  }

  def as_hash
    { :text => text,
      :user_name => user.name
    }
  end
end

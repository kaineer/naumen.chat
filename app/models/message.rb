class Message < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user
  validates_presence_of :text, :allow_blank => false

  scope :recent, includes(:user).order("id DESC").limit(20)
  scope :sent_after, lambda { |last_id|
    includes(:user).order("id DESC").where(["id > ?", last_id])
  }
  scope :for_display, select([:text, :user_id, :id])

  def as_hash
    { :text => text,
      :user_name => user.name
    }
  end
end

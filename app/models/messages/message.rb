class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :phone
  
  after_create :send_message
  
  def to_s
    text || "You need to come home ASAP!"
  end
end

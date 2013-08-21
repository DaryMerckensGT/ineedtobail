class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :phone
  
  after_create :delay_send_message
  
  def to_s
    text || "You need to come home ASAP!"
  end
  
  def delay_send_message
    repititions.times do |i|
      delay(run_at: send_at + (i * interval).minutes).send_message
    end
  end
end

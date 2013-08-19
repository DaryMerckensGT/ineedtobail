class Text < Message
  def self.model_name
    Message.model_name
  end
  
  def send_message
    client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    number = ENV['TWILIO_NUMBERS'].split(",").sample
    client.account.sms.messages.create(
      :from => "+1#{number}",
      :to => phone.to_s,
      :body => to_s
    )
  end
end
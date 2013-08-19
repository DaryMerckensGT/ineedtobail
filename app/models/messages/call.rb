class Call < Message
  def self.model_name
    Message.model_name
  end
  
  def schedule_delivery
    send_message
  end
  
  def send_message
    client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    domain = Rails.env == 'production' ? 'ineedtobail.herokuapp.com' : 'ineedtobail-staging.herokuapp.com'
    number = ENV['TWILIO_NUMBERS'].split(",").sample
    call = client.account.calls.create(
      :from => "+1#{number}",
      :to => phone.to_s,
      :url => "http://#{domain}/call.xml"
    )
  end
end

class Phone < ActiveRecord::Base
  belongs_to :user
  has_many :messages
  
  after_create :send_confirmation
  
  attr_accessor :confirm_via_text, :user_confirmation
  
  def to_s
    number.gsub(/\D/, '')
  end
  
  def twilio_confirmation_code
    confirmation_code.to_s.split('').join(" ")
  end
  
  def is_confirmed?
    confirmation_code.nil?
  end
  
  def send_confirmation
    generate_confirmation_code
    send_confirmation_code
  end
  
  def generate_confirmation_code
    update_column(:confirmation_code, rand(100000..999999))
  end
  
  def send_confirmation_code
    confirm_via_text == '1' ? text_confirmation_code : call_confirmation_code
  end
  
  def text_confirmation_code
    client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    number = ENV['TWILIO_NUMBERS'].split(",").sample
    client.account.sms.messages.create(
      :from => "+1#{number}",
      :to => to_s,
      :body => "Your confirmation code is #{confirmation_code}"
    )
  end
  
  def call_confirmation_code
    client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    domain = Rails.env == 'production' ? 'ineedtobail.herokuapp.com' : 'ineedtobail-staging.herokuapp.com'
    number = ENV['TWILIO_NUMBERS'].split(",").sample
    call = client.account.calls.create(
      :from => "+1#{number}",
      :to => to_s,
      :url => "http://#{domain}/phones/#{id}/confirmation.xml"
    )
  end
  
  def confirm
    if user_confirmation.to_i == confirmation_code
      update_column(:confirmation_code, nil)
    else
      increment!(:confirmation_tries)
      false
    end
  end
  
  def remaining_tries
    300 - confirmation_tries
  end
  
  def remaining_tries_string
    remaining_tries.to_s + " " + case remaining_tries
    when 1
      "try"
    else
      "tries"
    end
  end
end

class Phone < ActiveRecord::Base
  belongs_to :user
  has_many :messages
  
  after_create :send_confirmation
  
  def to_s
    number.gsub(/\D/, '')
  end
  
  def is_confirmed?
    confirmation_code.nil?
  end
  
  def send_confirmation
    generate_confirmation_code
    send_confirmation_code
  end
  
  def generate_confirmation_code
    # update_column(:confirmation_code, 123456)
  end
  
  def send_confirmation_code
    
  end
end

class PhonesController < InheritedResources::Base
  belongs_to :user
  
  def create
    @phone = Phone.new(phone_params)
    @phone.user = current_user
    
    create!{ user_phones_path(current_user) }
  end
  
  def phone_params
    params[:phone].permit!
  end
end

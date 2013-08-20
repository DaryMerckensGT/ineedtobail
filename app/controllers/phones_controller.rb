class PhonesController < InheritedResources::Base
  belongs_to :user
  
  def create
    @phone = Phone.new(phone_params)
    @phone.user = current_user
    
    create!{ user_phones_path(current_user) }
  end
  
  def update
    resource.user_confirmation = params[:phone][:user_confirmation]
    if resource.confirm
      flash[:notice] = "Phone successfully confirmed"
      redirect_to user_phones_path(current_user)
    else
      if resource.remaining_tries <= 0
        resource.destroy
        flash[:error] = "You entered too many incorrect confirmation codes. Please try adding your phone again."
        redirect_to user_phones_path(current_user)
      else
        flash[:error] = "Your confirmation code was incorrect. You have #{resource.remaining_tries_string} left."
        redirect_to confirm_user_phone_path(parent, resource)
      end
    end
  end
  
  def confirm
  end
  
  def resend_confirmation
    params[:method] == 'text' ? resource.text_confirmation_code : resource.call_confirmation_code
    
    flash[:notice] = "Confirmation code resent."
    redirect_to user_phones_path(current_user)
  end
  
  def confirmation
    @phone = Phone.find(params[:id])
    # notification = VendorAfterhoursNotificationLog.find_or_create_by_call_sid(params[:CallSid])
    #     if notification
    #       notification.call_started_at = Time.now
    #       notification.call_status = params[:CallStatus]
    #       notification.phone_number_called= params[:Called]
    #       notification.save
    #     end
    respond_to do |format|  
      format.xml
    end
  end
    
  private
  
  def phone_params
    params[:phone].permit!
  end
end

class PhonesController < InheritedResources::Base
  def create
    @phone = Phone.new(phone_params)
    @phone.user = current_user
    @phone.save
    
    redirect_to phones_path
  end
  
  def update
    resource.user_confirmation = params[:phone][:user_confirmation]
    if resource.confirm
      flash[:notice] = "Phone successfully confirmed"
      redirect_to phones_path
    else
      if resource.remaining_tries <= 0
        resource.destroy
        flash[:error] = "You entered too many incorrect confirmation codes. Please try adding your phone again."
        redirect_to phones_path
      else
        flash[:error] = "Your confirmation code was incorrect. You have #{resource.remaining_tries_string} left."
        redirect_to confirm_phone_path(resource)
      end
    end
  end
  
  def confirm
  end
  
  def resend_confirmation
    params[:method] == 'text' ? resource.text_confirmation_code : resource.call_confirmation_code
    
    flash[:notice] = "Confirmation code resent."
    redirect_to phones_path
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

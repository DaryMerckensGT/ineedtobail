class CallsController < InheritedResources::Base
  protect_from_forgery :except => [:message]
  
  def message
    @call = Call.find(params[:id])
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
end
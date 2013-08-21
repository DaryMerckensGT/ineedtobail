class MessagesController < InheritedResources::Base
  belongs_to :user
  
  before_filter :fix_date, only: :create
  
  def create
    @message = Message.new(message_params)
    @message.user = current_user
    
    create!{ user_messages_path(parent) }
  end
  
  private
  
  def message_params
    params[:message].permit!
  end
  
  def fix_date
    # raise (Time.zone.utc_offset/3600).to_s
    # params[:message][:send_at] = Time.use_zone(current_user.time_zone) {DateTime.strptime("#{params[:message][:send_at]}", "%m/%d/%Y %I:%M %p").in_time_zone(current_user.time_zone)}
    # raise params[:message][:send_at].to_yaml
    # raise Time.zone.to_yaml
    # params[:message][:send_at] = DateTime.strptime(params[:message][:send_at],"%m/%d/%Y %I:%M %p") - (Time.zone.utc_offset/3600).hours
    # raise (params[:message][:send_at]).to_yaml
    
    # Time.use_zone(current_user.time_zone) do
      params[:message][:send_at] = DateTime.strptime(params[:message][:send_at],"%m/%d/%Y %I:%M %p") + 4.hours #- (Time.zone.utc_offset/3600).hours
    #   raise (params[:message][:send_at]).to_yaml
    # end
  end
end

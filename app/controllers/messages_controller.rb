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
    params[:message][:send_at] = DateTime.strptime(params[:message][:send_at],"%m/%d/%Y %I:%M:%S %p")
  end
end

class MessagesController < InheritedResources::Base
  def create
    @message = Message.new(message_params)
    @message.user = current_user
    
    create!{ messages_path }
  end
  
  private
  
  def message_params
    params[:message].permit!
  end
end

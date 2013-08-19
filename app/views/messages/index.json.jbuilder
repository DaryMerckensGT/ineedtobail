json.array!(@messages) do |message|
  json.extract! message, :user_id, :send_at, :text, :type
  json.url message_url(message, format: :json)
end

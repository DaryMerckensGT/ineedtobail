# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    user nil
    send_at "2013-08-11 12:43:23"
    text "MyText"
    type ""
  end
end

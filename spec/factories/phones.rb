# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :phone do
    user nil
    number "MyString"
    confirmation_code 1
    confirmation_tries 1
  end
end

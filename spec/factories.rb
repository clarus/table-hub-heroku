FactoryGirl.define do
  factory :user do
    name "Guillaume Claret"
    email "guillaume@mail.com"
    password "secret"
    password_confirmation "secret"
  end
end
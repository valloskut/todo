# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :to_do do
    sequence(:title) {|n| "ToDo #{n}"}
  end
end

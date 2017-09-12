FactoryGirl.define do
  factory :invoice do
    association :vendor, factory: :vendor_with_stripe_acct
    name 'Awesome plan'
    description Faker::Lorem.paragraph
    amount 1000
    id_for_plan 'Awesome invoice2'
  end
end

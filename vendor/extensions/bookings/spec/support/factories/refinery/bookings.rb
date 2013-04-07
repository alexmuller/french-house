
FactoryGirl.define do
  factory :booking, :class => Refinery::Bookings::Booking do
    sequence(:contact_name) { |n| "refinery#{n}" }
  end
end


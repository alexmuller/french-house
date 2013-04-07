module Refinery
  module Bookings
    class Booking < Refinery::Core::BaseModel
      self.table_name = 'refinery_bookings'

      attr_accessible :start_date, :end_date, :contact_name, :contact_number, :contact_email, :confirmed, :position

      acts_as_indexed :fields => [:contact_name, :contact_number, :contact_email]

      validates :contact_name, :presence => true, :uniqueness => true
    end
  end
end

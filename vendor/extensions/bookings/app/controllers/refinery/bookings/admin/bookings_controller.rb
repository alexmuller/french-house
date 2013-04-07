module Refinery
  module Bookings
    module Admin
      class BookingsController < ::Refinery::AdminController

        crudify :'refinery/bookings/booking',
                :title_attribute => 'contact_name', :xhr_paging => true

      end
    end
  end
end

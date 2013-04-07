require 'spec_helper'

module Refinery
  module Bookings
    describe Booking do
      describe "validations" do
        subject do
          FactoryGirl.create(:booking,
          :contact_name => "Refinery CMS")
        end

        it { should be_valid }
        its(:errors) { should be_empty }
        its(:contact_name) { should == "Refinery CMS" }
      end
    end
  end
end

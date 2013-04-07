# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Bookings" do
    describe "Admin" do
      describe "bookings" do
        login_refinery_user

        describe "bookings list" do
          before do
            FactoryGirl.create(:booking, :contact_name => "UniqueTitleOne")
            FactoryGirl.create(:booking, :contact_name => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.bookings_admin_bookings_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.bookings_admin_bookings_path

            click_link "Add New Booking"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Contact Name", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::Bookings::Booking.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Contact Name can't be blank")
              Refinery::Bookings::Booking.count.should == 0
            end
          end

          context "duplicate" do
            before { FactoryGirl.create(:booking, :contact_name => "UniqueTitle") }

            it "should fail" do
              visit refinery.bookings_admin_bookings_path

              click_link "Add New Booking"

              fill_in "Contact Name", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::Bookings::Booking.count.should == 1
            end
          end

        end

        describe "edit" do
          before { FactoryGirl.create(:booking, :contact_name => "A contact_name") }

          it "should succeed" do
            visit refinery.bookings_admin_bookings_path

            within ".actions" do
              click_link "Edit this booking"
            end

            fill_in "Contact Name", :with => "A different contact_name"
            click_button "Save"

            page.should have_content("'A different contact_name' was successfully updated.")
            page.should have_no_content("A contact_name")
          end
        end

        describe "destroy" do
          before { FactoryGirl.create(:booking, :contact_name => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.bookings_admin_bookings_path

            click_link "Remove this booking forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::Bookings::Booking.count.should == 0
          end
        end

      end
    end
  end
end

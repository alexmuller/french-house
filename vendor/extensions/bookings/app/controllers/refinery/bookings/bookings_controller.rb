module Refinery
  module Bookings
    class BookingsController < ::ApplicationController

      before_filter :find_page

      def index
        date_from = Date.today.beginning_of_week
        date_to = (date_from + 11.weeks).end_of_week
        bookings = Booking.where("start_date <= ? AND end_date >= ?", date_to, date_from)
        booked_dates = bookings.collect_concat do |b|
          (b.start_date..b.end_date).map { |d| Date.new(d.year, d.month, d.day) }
        end
        @days = (date_from..date_to).map do |d|
          date = Date.new(d.year, d.month, d.day)
          {
            :date => date,
            :booked => booked_dates.include?(date) ? true : false
          }
        end
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @booking in the line below:
        present(@page)
      end

      def show
        @booking = Booking.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @booking in the line below:
        present(@page)
      end

    protected

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/bookings").first
      end

    end
  end
end

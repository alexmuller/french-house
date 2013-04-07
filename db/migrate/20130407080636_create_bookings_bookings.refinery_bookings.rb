# This migration comes from refinery_bookings (originally 1)
class CreateBookingsBookings < ActiveRecord::Migration

  def up
    create_table :refinery_bookings do |t|
      t.date :start_date
      t.date :end_date
      t.string :contact_name
      t.string :contact_number
      t.string :contact_email
      t.boolean :confirmed
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-bookings"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/bookings/bookings"})
    end

    drop_table :refinery_bookings

  end

end

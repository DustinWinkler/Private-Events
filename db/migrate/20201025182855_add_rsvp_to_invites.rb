class AddRsvpToInvites < ActiveRecord::Migration[5.2]
  def change
    change_table :invites do |t|
      t.string :rsvp, default: "pending"
    end
  end
end

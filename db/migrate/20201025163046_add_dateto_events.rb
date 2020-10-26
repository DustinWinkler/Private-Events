class AddDatetoEvents < ActiveRecord::Migration[5.2]
  def change
    change_table :events do |t|
      t.datetime :date
      
    end

  end
end

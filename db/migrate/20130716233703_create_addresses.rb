class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :patient_id
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.string :name

      t.timestamps
    end
  end
end

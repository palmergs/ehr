class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.integer :user_id
      t.integer :patient_id
      t.string :appointment_type
      t.datetime :start_at
      t.datetime :end_at
      t.datetime :canceled_at
      t.string :notes

      t.timestamps
    end
  end
end

class AddAppointmentToTables < ActiveRecord::Migration
  def change
    add_column :prescriptions, :appointment_id, :integer
    add_index :prescriptions, :appointment_id

    add_column :allergies, :appointment_id, :integer
    add_index  :allergies, :appointment_id
  end
end

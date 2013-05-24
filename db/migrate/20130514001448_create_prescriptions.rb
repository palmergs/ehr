class CreatePrescriptions < ActiveRecord::Migration
  def change
    create_table :prescriptions do |t|
      t.integer :user_id
      t.integer :patient_id
      t.string :medication_status
      t.string :prescription
      t.string :notes

      t.timestamps
    end
  end
end

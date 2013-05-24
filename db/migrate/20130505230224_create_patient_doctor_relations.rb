class CreatePatientDoctorRelations < ActiveRecord::Migration
  def change
    create_table :patient_doctor_relations do |t|
      t.integer :user_id
      t.integer :patient_id

      t.timestamps
    end
  end
end

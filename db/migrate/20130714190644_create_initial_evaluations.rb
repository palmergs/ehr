class CreateInitialEvaluations < ActiveRecord::Migration
  def change
    create_table :initial_evaluations do |t|
      t.integer :user_id
      t.integer :patient_id
      t.integer :appointment_id
      t.string :id_cc
      t.string :hpi
      t.string :mental_status_exam
      t.string :formulation
      t.string :recommendation

      t.timestamps
    end
  end
end

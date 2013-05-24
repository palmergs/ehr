class CreateAllergies < ActiveRecord::Migration
  def change
    create_table :allergies do |t|
      t.integer :user_id
      t.integer :patient_id
      t.string :medication_or_food
      t.string :reaction

      t.timestamps
    end
  end
end

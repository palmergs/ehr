class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :patient_id
      t.string :name
      t.string :contact
      t.string :msg_instr

      t.timestamps
    end
  end
end

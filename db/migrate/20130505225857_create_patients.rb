class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      
      t.string :ident, length: 6
      t.string :fname
      t.string :lname
      t.string :mname
      t.date :dob
      t.string :status
      t.string :gender, length: 2
      t.string :ethnicity
      t.string :occupation
      t.string :marital_status

      t.timestamps
    end
  end
end

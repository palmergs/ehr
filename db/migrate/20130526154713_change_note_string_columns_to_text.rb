class ChangeNoteStringColumnsToText < ActiveRecord::Migration
  def change
    change_column :appointments, :notes, :text, limit: nil, default: ''
    change_column :prescriptions, :notes, :text, limit: nil, default: ''

    change_column :progress_notes, :interim_history, :text, limit: nil
    change_column :progress_notes, :medications_side_effects, :text
    change_column :progress_notes, :impression_diagnosis, :text
    change_column :progress_notes, :plan, :text
  end
end

class CreateProgressNotes < ActiveRecord::Migration
  def change
    create_table :progress_notes do |t|
      t.integer :user_id
      t.integer :patient_id
      t.integer :appointment_id
      t.string :interim_history
      t.string :medications_side_effects
      t.string :impression_diagnosis
      t.string :plan
      t.string :therapy_type
      t.string :therapy_mins
      t.boolean :majority_counceling_coord
      t.string :appearance
      t.string :behavior
      t.string :speech
      t.string :though_process
      t.string :mood_affect
      t.string :vital_sense
      t.string :sihi
      t.string :hallucinations
      t.string :delusions
      t.string :phobias_obsessions
      t.string :cognitive_state
      t.string :insight_judgement

      t.timestamps
    end
  end
end

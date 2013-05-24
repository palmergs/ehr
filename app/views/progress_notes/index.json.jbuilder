json.array!(@progress_notes) do |progress_note|
  json.extract! progress_note, :user_id, :patient_id, :appointment_id, :interim_history, :medications_side_effects, :impression_diagnosis, :plan, :therapy_type, :therapy_mins, :majority_counceling_coord, :appearance, :behavior, :speech, :though_process, :mood_affect, :vital_sense, :sihi, :hallucinations, :delusions, :phobias_obsessions, :cognitive_state, :insight_judgement
  json.url progress_note_url(progress_note, format: :json)
end
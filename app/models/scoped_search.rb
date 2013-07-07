module ScopedSearch
  def inner_join_relations
    <<-STR
      inner join patient_doctor_relations 
      on patient_doctor_relations.patient_id = #{ table_name }.patient_id
    STR
  end

  def allowed_user_lambda
    ->(user) {
      joins(inner_join_relations).
          where('patient_doctor_relations.user_id = ?', user.id)
    }
  end

  def date_range_lambda
    ->(stdt, endt, field = :created_at) {
      if stdt.present? and endt.present?
        where(field.to_sym => (stdt..endt))
      elsif stdt.present?
        where('? >= ?', field, stdt)
      elsif endt.present?
        where('? <= ?', field, endt)
      end
    }
  end

  def fields_like_lambda
    ->(q, fields) {
      if q.present?
        term = "%#{ q }%"
        query = Array(fields).map do |f|
          "#{ f } like ?"
        end.join(' or ')
        arr = query
        Array(fields).count.times { arr << term }
        where(arr)
      end
    }
  end
end

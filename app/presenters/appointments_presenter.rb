class AppointmentsPresenter < CollectionPresenter

  def initialize current_user, params
    @criteria = Appointment.by_allowed_user(current_user).
        by_user(params[:uid]).
        by_patient(params[:patient_id]).
        joins(:patient).
        joins(:user)
    @criteria.order(sort_order(params))
    @collection = @criteria.page(page(params)).per(limit(params))
  end

  def sortable_columns
    [:start_at, 'patients.ident'.to_sym]
  end

  def default_sort_dir
    :desc
  end

  def to_json
    now = Time.now
    hash = @collection.inject({}) do |hash, appt|
      hash[appt.date_str] = { 
          type: appt.appointment_type, 
          status: (appt.canceled_at.nil? ? 
              (now < appt.start_at ? 'Pending' : 'Occurred') : 
              'Canceled') }
      hash
    end
    hash.to_json
  end
end

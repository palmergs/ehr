class PrescriptionsPresenter < CollectionPresenter
  def initialize current_user, params
    @criteria = Prescription.by_allowed_user(current_user).
        by_user(params[:uid]).
        by_patient(params[:patient_id]).
        joins(:patient).
        joins(:user)
    @criteria.order(sort_order(params))
    @collection = @criteria.page(page(params)).per(limit(params))
  end

  def sortable_columns
    [:medication_status, :prescription, 'patient.ident'.to_sym, 'user.lname'.to_sym]
  end
end

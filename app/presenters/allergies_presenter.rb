class AllergiesPresenter < CollectionPresenter

  def initialize current_user, params
    @criteria = Allergy.by_allowed_user(current_user).
        by_user(params[:uid]).
        by_patient(params[:patient_id]).
        joins(:patient).
        joins(:user)
    @criteria.order(sort_order(params))
    @collection = @criteria.page(page(params)).per(limit(params))
  end

  def sortable_columns
    [:medication_or_food, 'patients.ident'.to_sym]
  end

  def default_sort_dir
    :asc
  end
end

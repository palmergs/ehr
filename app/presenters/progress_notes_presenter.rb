class ProgressNotesPresenter < CollectionPresenter
  def initialize current_user, params
    @criteria = ProgressNote.by_allowed_user(current_user).
        by_user(params[:uid]).
        by_patient(params[:patient_id]).
        joins(:patient).
        joins(:user).
        joins(:appointment)
    @criteria.order(sort_order(params))
    @collection = @criteria.page(page(params)).per(limit(params))
  end

  def sortable_columns
    [:created_at, 'patients.ident'.to_sym]
  end

  def default_sort_dir
    :desc
  end
end

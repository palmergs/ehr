class CollectionPresenter

  DEFAULT_PAGE_SIZE = 30

  attr_reader :criteria, :collection

  delegate :count, :size, :length, :empty?, :each, :each_with_index, :map,
      :current_page, :num_pages, :total_pages, :limit_value, :include?, :first, :inject,
      to: :collection

  def page params, key = :page
    [params[key].to_i, 0].max
  end

  def limit params, key = :limit
    params[key].to_i > 0 ? params[key].to_i : DEFAULT_PAGE_SIZE
  end

  def sort_order params, key = :o, dkey = :d
    col = params[key]
    if col and sortable_columns.include?(col.to_sym)
      dir = params[dkey] && [:acs, :desc].include?(params[dkey].to_sym) ?
          params[dkey] :
          default_sort_dir
      "#{ col } #{ dir }"
    else
      default_sort
    end
  end

  def sortable_columns
    [:id]
  end

  def default_sort_col
    sortable_columns.first
  end

  def default_sort_dir
    :asc
  end

  private

  def default_sort
    "#{ default_sort_col } #{ default_sort_dir }"
  end
end

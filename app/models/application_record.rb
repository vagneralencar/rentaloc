class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  
  # Método auxiliar para busca
  def self.search(query)
    return all unless query.present?
    
    where(
      searchable_columns.map { |column| "#{column} ILIKE :query" }.join(' OR '),
      query: "%#{query}%"
    )
  end
  
  # Método auxiliar para paginação
  def self.paginate(page: 1, per_page: 20)
    page(page).per(per_page)
  end
  
  private
  
  # Método para definir colunas pesquisáveis
  def self.searchable_columns
    []
  end
end

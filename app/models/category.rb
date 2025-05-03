class Category < ApplicationRecord
  include MultiTenant
  
  # Associações
  belongs_to :tenant
  belongs_to :parent, class_name: 'Category', optional: true
  has_many :children, class_name: 'Category', foreign_key: :parent_id, dependent: :destroy
  
  # Validações
  validates :name, presence: true
  validates :code, presence: true, uniqueness: { scope: :tenant_id }
  validate :parent_from_same_tenant
  validate :prevent_self_parent
  
  # Enums
  enum category_type: {
    equipment: 0,
    service: 1,
    financial: 2,
    cost_center: 3
  }
  
  # Callbacks
  before_validation :generate_code, on: :create
  
  # Scopes
  scope :roots, -> { where(parent_id: nil) }
  scope :by_type, ->(type) { where(category_type: type) }
  
  # Métodos
  def root?
    parent_id.nil?
  end
  
  def leaf?
    children.empty?
  end
  
  def ancestors
    return [] if root?
    parent.ancestors + [parent]
  end
  
  def descendants
    children.flat_map { |child| [child] + child.descendants }
  end
  
  def full_name
    ancestors.map(&:name).push(name).join(' > ')
  end
  
  private
  
  def parent_from_same_tenant
    return if parent.nil? || parent.tenant_id == tenant_id
    errors.add(:parent_id, "deve pertencer ao mesmo tenant")
  end
  
  def prevent_self_parent
    return if parent_id.nil?
    errors.add(:parent_id, "não pode ser a própria categoria") if parent_id == id
  end
  
  def generate_code
    return if code.present?
    
    prefix = case category_type
            when 'equipment' then 'EQ'
            when 'service' then 'SV'
            when 'financial' then 'FN'
            when 'cost_center' then 'CC'
            end
    
    last_code = tenant.categories
                     .where(category_type: category_type)
                     .where("code LIKE ?", "#{prefix}%")
                     .order(code: :desc)
                     .first&.code
    
    sequence = if last_code
                 last_code.match(/\d+$/)[0].to_i + 1
               else
                 1
               end
    
    self.code = "#{prefix}#{sequence.to_s.rjust(4, '0')}"
  end
end
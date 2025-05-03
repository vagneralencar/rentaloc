class Observation < ApplicationRecord
  acts_as_tenant(:tenant)

  # Relacionamentos
  belongs_to :tenant
  belongs_to :observable, polymorphic: true
  belongs_to :user

  # Validações
  validates :content, presence: true

  # Scopes
  scope :ordered, -> { order(created_at: :desc) }
  scope :by_user, ->(user_id) { where(user_id: user_id) }
  scope :by_date_range, ->(start_date, end_date) { where(created_at: start_date..end_date) }
end 
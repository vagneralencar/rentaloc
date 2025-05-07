class PersonDocument < ApplicationRecord
  acts_as_tenant(:tenant)
  belongs_to :person
  belongs_to :tenant
  has_one_attached :file
  validates :file, presence: true
  validates :description, presence: true
end

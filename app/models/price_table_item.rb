class PriceTableItem < ApplicationRecord
  acts_as_tenant(:tenant)

  # Relacionamentos
  belongs_to :tenant
  belongs_to :price_table
  belongs_to :equipment

  # Validações
  validates :daily_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :minimum_daily_price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :minimum_rental_days, numericality: { greater_than: 0 }, allow_nil: true
  validates :equipment_id, uniqueness: { scope: :price_table_id }

  # Métodos
  def calculate_price(days)
    return 0 if days.blank? || days <= 0

    # Aplica o preço mínimo se configurado
    if minimum_rental_days.present? && days < minimum_rental_days
      return minimum_daily_price.present? ? minimum_daily_price * days : daily_price * days
    end

    # Calcula o preço baseado no período
    case days
    when 1..6
      daily_price * days
    when 7..13
      weekly_price.present? ? weekly_price : daily_price * days
    when 14..29
      biweekly_price.present? ? biweekly_price : daily_price * days
    when 30..89
      monthly_price.present? ? monthly_price : daily_price * days
    when 90..179
      quarterly_price.present? ? quarterly_price : daily_price * days
    when 180..364
      semester_price.present? ? semester_price : daily_price * days
    else
      yearly_price.present? ? yearly_price : daily_price * days
    end
  end

  def calculate_proportional_price(days)
    return 0 if days.blank? || days <= 0

    # Se for menos que o mínimo de dias, usa o preço diário mínimo ou normal
    if minimum_rental_days.present? && days < minimum_rental_days
      daily = minimum_daily_price.present? ? minimum_daily_price : daily_price
      return (daily * days).round(2)
    end

    # Calcula o preço proporcional baseado no período
    case days
    when 1..6
      (daily_price * days).round(2)
    when 7..13
      weekly_price.present? ? (weekly_price / 7.0 * days).round(2) : (daily_price * days).round(2)
    when 14..29
      biweekly_price.present? ? (biweekly_price / 15.0 * days).round(2) : (daily_price * days).round(2)
    when 30..89
      monthly_price.present? ? (monthly_price / 30.0 * days).round(2) : (daily_price * days).round(2)
    when 90..179
      quarterly_price.present? ? (quarterly_price / 90.0 * days).round(2) : (daily_price * days).round(2)
    when 180..364
      semester_price.present? ? (semester_price / 180.0 * days).round(2) : (daily_price * days).round(2)
    else
      yearly_price.present? ? (yearly_price / 365.0 * days).round(2) : (daily_price * days).round(2)
    end
  end
end 
class EquipmentSchedule < ApplicationRecord
  belongs_to :equipment
  belongs_to :user, optional: true

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :schedule_type, presence: true
  validates :description, presence: true
  validate :end_date_after_start_date

  enum schedule_type: {
    locacao: 'locacao',
    manutencao: 'manutencao',
    reserva: 'reserva',
    outro: 'outro'
  }

  enum status: {
    agendado: 'agendado',
    em_andamento: 'em_andamento',
    concluido: 'concluido',
    cancelado: 'cancelado'
  }

  before_validation :set_user, on: :create
  before_validation :set_default_status, on: :create

  private

  def set_user
    self.user = Current.user if Current.user
  end

  def set_default_status
    self.status ||= :agendado
  end

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "deve ser posterior à data de início")
    end
  end
end 
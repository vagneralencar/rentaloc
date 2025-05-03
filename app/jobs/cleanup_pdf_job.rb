class CleanupPdfJob < ApplicationJob
  queue_as :default
  
  def perform
    # Encontrar relatórios antigos (mais de 30 dias)
    old_reports = EquipmentMaintenanceReport.where('created_at < ?', 30.days.ago)
    
    old_reports.find_each do |report|
      # Verificar se o relatório está arquivado
      if report.archived?
        # Remover o PDF
        report.pdf.purge if report.pdf.attached?
      end
    end
  end
end 
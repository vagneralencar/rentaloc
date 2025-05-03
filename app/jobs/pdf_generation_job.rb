class PdfGenerationJob < ApplicationJob
  queue_as :pdf_generation

  def perform(report_id)
    report = EquipmentMaintenanceReport.find(report_id)
    
    # Gerar o PDF
    pdf = WickedPdf.new.pdf_from_string(
      render_to_string(
        template: 'equipment_maintenance_reports/show',
        layout: 'pdf',
        locals: { report: report }
      ),
      encoding: 'UTF-8'
    )
    
    # Salvar o PDF
    report.pdf.attach(
      io: StringIO.new(pdf),
      filename: "relatorio_manutencao_#{report.id}.pdf",
      content_type: 'application/pdf'
    )
    
    # Atualizar o status do relatório
    report.update(status: :generated)
    
    # Enviar e-mail com o PDF
    EquipmentMaintenanceReportMailer.report_generated(report).deliver_later
  rescue StandardError => e
    # Registrar o erro
    Rails.logger.error("Erro ao gerar PDF: #{e.message}")
    
    # Atualizar o status do relatório
    report.update(status: :failed)
    
    # Enviar e-mail de erro
    EquipmentMaintenanceReportMailer.report_generation_failed(report, e.message).deliver_later
    
    # Relançar a exceção para o Sidekiq
    raise e
  end
end 
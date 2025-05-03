class EquipmentMaintenanceReportMailer < ApplicationMailer
  def report_generated(report)
    @report = report
    @equipment = report.equipment
    @user = report.generated_by
    
    attachments["relatorio_manutencao_#{report.id}.pdf"] = {
      mime_type: 'application/pdf',
      content: report.pdf.download
    }
    
    mail(
      to: @user.email,
      subject: "Relatório de Manutenção - #{@equipment.name}",
      template_name: 'report_generated'
    )
  end
  
  def report_generation_failed(report, error_message)
    @report = report
    @equipment = report.equipment
    @user = report.generated_by
    @error_message = error_message
    
    mail(
      to: @user.email,
      subject: "Erro na Geração do Relatório de Manutenção - #{@equipment.name}",
      template_name: 'report_generation_failed'
    )
  end
end 
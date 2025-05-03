class EquipmentMaintenanceReportsController < ApplicationController
  before_action :set_equipment_maintenance_report, only: [:show, :edit, :update, :destroy]
  
  def index
    @equipment_maintenance_reports = current_tenant.equipment_maintenance_reports
      .includes(:equipment, :generated_by)
      .order(created_at: :desc)
  end
  
  def show
    respond_to do |format|
      format.html
      format.turbo_stream
      format.pdf do
        if @equipment_maintenance_report.pdf.attached?
          send_data @equipment_maintenance_report.pdf.download,
                    filename: "relatorio_manutencao_#{@equipment_maintenance_report.id}.pdf",
                    type: 'application/pdf',
                    disposition: 'inline'
        else
          # Iniciar a geração do PDF em background
          PdfGenerationJob.perform_later(@equipment_maintenance_report.id)
          
          # Redirecionar com mensagem
          redirect_to @equipment_maintenance_report,
                      notice: 'O relatório está sendo gerado. Você receberá um e-mail quando estiver pronto.'
        end
      end
    end
  end
  
  def new
    @equipment_maintenance_report = current_tenant.equipment_maintenance_reports.build
    @equipment_maintenance_report.generated_by = current_user
  end
  
  def edit
  end
  
  def create
    @equipment_maintenance_report = current_tenant.equipment_maintenance_reports.build(equipment_maintenance_report_params)
    @equipment_maintenance_report.generated_by = current_user
    
    respond_to do |format|
      if @equipment_maintenance_report.save
        # Iniciar a geração do PDF em background
        PdfGenerationJob.perform_later(@equipment_maintenance_report.id)
        
        format.turbo_stream { 
          render turbo_stream: [
            turbo_stream.append('equipment_maintenance_reports', partial: 'equipment_maintenance_reports/report_frame', locals: { report: @equipment_maintenance_report }),
            turbo_stream.update('flash', partial: 'shared/flash', locals: { message: 'Relatório criado com sucesso! O PDF está sendo gerado em background.', type: 'success' })
          ]
        }
        format.html { redirect_to @equipment_maintenance_report, notice: 'Relatório criado com sucesso! O PDF está sendo gerado em background.' }
      else
        format.turbo_stream { 
          render turbo_stream: turbo_stream.update('flash', partial: 'shared/flash', locals: { message: 'Erro ao criar relatório.', type: 'error' })
        }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    respond_to do |format|
      if @equipment_maintenance_report.update(equipment_maintenance_report_params)
        # Iniciar a geração do PDF em background
        PdfGenerationJob.perform_later(@equipment_maintenance_report.id)
        
        format.turbo_stream { 
          render turbo_stream: [
            turbo_stream.replace(@equipment_maintenance_report, partial: 'equipment_maintenance_reports/report_frame', locals: { report: @equipment_maintenance_report }),
            turbo_stream.update('flash', partial: 'shared/flash', locals: { message: 'Relatório atualizado com sucesso! O PDF está sendo gerado em background.', type: 'success' })
          ]
        }
        format.html { redirect_to @equipment_maintenance_report, notice: 'Relatório atualizado com sucesso! O PDF está sendo gerado em background.' }
      else
        format.turbo_stream { 
          render turbo_stream: turbo_stream.update('flash', partial: 'shared/flash', locals: { message: 'Erro ao atualizar relatório.', type: 'error' })
        }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @equipment_maintenance_report.destroy
    
    respond_to do |format|
      format.turbo_stream { 
        render turbo_stream: [
          turbo_stream.remove(@equipment_maintenance_report),
          turbo_stream.update('flash', partial: 'shared/flash', locals: { message: 'Relatório excluído com sucesso!', type: 'success' })
        ]
      }
      format.html { redirect_to equipment_maintenance_reports_path, notice: 'Relatório excluído com sucesso!' }
    end
  end
  
  private
  
  def set_equipment_maintenance_report
    @equipment_maintenance_report = current_tenant.equipment_maintenance_reports.find(params[:id])
  end
  
  def equipment_maintenance_report_params
    params.require(:equipment_maintenance_report).permit(
      :equipment_id,
      :report_type,
      :start_date,
      :end_date,
      :status,
      :additional_data
    )
  end
end 
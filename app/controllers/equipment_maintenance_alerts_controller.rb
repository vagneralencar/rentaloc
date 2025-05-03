class EquipmentMaintenanceAlertsController < ApplicationController
  before_action :set_equipment_maintenance_alert, only: [:show, :edit, :update, :destroy]
  
  def index
    @equipment_maintenance_alerts = current_tenant.equipment_maintenance_alerts
      .includes(:equipment, :created_by)
      .order(created_at: :desc)
  end
  
  def show
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end
  
  def new
    @equipment_maintenance_alert = current_tenant.equipment_maintenance_alerts.build
    @equipment_maintenance_alert.created_by = current_user
  end
  
  def edit
  end
  
  def create
    @equipment_maintenance_alert = current_tenant.equipment_maintenance_alerts.build(equipment_maintenance_alert_params)
    @equipment_maintenance_alert.created_by = current_user
    
    respond_to do |format|
      if @equipment_maintenance_alert.save
        format.turbo_stream { 
          render turbo_stream: [
            turbo_stream.append('equipment_maintenance_alerts', partial: 'equipment_maintenance_alerts/alert_frame', locals: { alert: @equipment_maintenance_alert }),
            turbo_stream.update('flash', partial: 'shared/flash', locals: { message: 'Alerta criado com sucesso!', type: 'success' })
          ]
        }
        format.html { redirect_to @equipment_maintenance_alert, notice: 'Alerta criado com sucesso!' }
      else
        format.turbo_stream { 
          render turbo_stream: turbo_stream.update('flash', partial: 'shared/flash', locals: { message: 'Erro ao criar alerta.', type: 'error' })
        }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    respond_to do |format|
      if @equipment_maintenance_alert.update(equipment_maintenance_alert_params)
        format.turbo_stream { 
          render turbo_stream: [
            turbo_stream.replace(@equipment_maintenance_alert, partial: 'equipment_maintenance_alerts/alert_frame', locals: { alert: @equipment_maintenance_alert }),
            turbo_stream.update('flash', partial: 'shared/flash', locals: { message: 'Alerta atualizado com sucesso!', type: 'success' })
          ]
        }
        format.html { redirect_to @equipment_maintenance_alert, notice: 'Alerta atualizado com sucesso!' }
      else
        format.turbo_stream { 
          render turbo_stream: turbo_stream.update('flash', partial: 'shared/flash', locals: { message: 'Erro ao atualizar alerta.', type: 'error' })
        }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @equipment_maintenance_alert.destroy
    
    respond_to do |format|
      format.turbo_stream { 
        render turbo_stream: [
          turbo_stream.remove(@equipment_maintenance_alert),
          turbo_stream.update('flash', partial: 'shared/flash', locals: { message: 'Alerta excluído com sucesso!', type: 'success' })
        ]
      }
      format.html { redirect_to equipment_maintenance_alerts_path, notice: 'Alerta excluído com sucesso!' }
    end
  end
  
  private
  
  def set_equipment_maintenance_alert
    @equipment_maintenance_alert = current_tenant.equipment_maintenance_alerts.find(params[:id])
  end
  
  def equipment_maintenance_alert_params
    params.require(:equipment_maintenance_alert).permit(
      :equipment_id,
      :equipment_maintenance_schedule_id,
      :alert_type,
      :status,
      :priority,
      :message,
      :due_date,
      :notes
    )
  end
end 
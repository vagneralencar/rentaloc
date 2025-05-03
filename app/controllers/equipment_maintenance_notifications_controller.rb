class EquipmentMaintenanceNotificationsController < ApplicationController
  before_action :set_equipment_maintenance_notification, only: [:show, :destroy, :mark_as_read]
  
  def index
    @equipment_maintenance_notifications = current_tenant.equipment_maintenance_notifications
      .includes(:equipment_maintenance_alert, :user)
      .order(created_at: :desc)
  end
  
  def show
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end
  
  def destroy
    @equipment_maintenance_notification.destroy
    
    respond_to do |format|
      format.turbo_stream { 
        render turbo_stream: [
          turbo_stream.remove(@equipment_maintenance_notification),
          turbo_stream.update('flash', partial: 'shared/flash', locals: { message: 'Notificação excluída com sucesso!', type: 'success' })
        ]
      }
      format.html { redirect_to equipment_maintenance_notifications_path, notice: 'Notificação excluída com sucesso!' }
    end
  end
  
  def mark_as_read
    @equipment_maintenance_notification.update(
      status: :read,
      read_at: Time.current
    )
    
    respond_to do |format|
      format.turbo_stream { 
        render turbo_stream: [
          turbo_stream.replace(@equipment_maintenance_notification, partial: 'equipment_maintenance_notifications/notification_frame', locals: { notification: @equipment_maintenance_notification }),
          turbo_stream.update('flash', partial: 'shared/flash', locals: { message: 'Notificação marcada como lida!', type: 'success' })
        ]
      }
      format.html { redirect_to equipment_maintenance_notifications_path, notice: 'Notificação marcada como lida!' }
    end
  end
  
  private
  
  def set_equipment_maintenance_notification
    @equipment_maintenance_notification = current_tenant.equipment_maintenance_notifications.find(params[:id])
  end
end 
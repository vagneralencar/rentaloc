class EquipmentMaintenancesController < ApplicationController
  before_action :set_equipment_maintenance, only: [:show, :edit, :update, :destroy]
  
  def index
    @equipment_maintenances = current_tenant.equipment_maintenances
      .includes(:equipment)
      .order(created_at: :desc)
  end
  
  def show
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end
  
  def new
    @equipment_maintenance = current_tenant.equipment_maintenances.build
    @equipment_maintenance.created_by = current_user
  end
  
  def edit
  end
  
  def create
    @equipment_maintenance = current_tenant.equipment_maintenances.build(equipment_maintenance_params)
    @equipment_maintenance.created_by = current_user
    
    respond_to do |format|
      if @equipment_maintenance.save
        format.turbo_stream { 
          render turbo_stream: [
            turbo_stream.append('equipment_maintenances', partial: 'equipment_maintenances/maintenance_frame', locals: { maintenance: @equipment_maintenance }),
            turbo_stream.update('flash', partial: 'shared/flash', locals: { message: 'Manutenção criada com sucesso!', type: 'success' })
          ]
        }
        format.html { redirect_to @equipment_maintenance, notice: 'Manutenção criada com sucesso!' }
      else
        format.turbo_stream { 
          render turbo_stream: turbo_stream.update('flash', partial: 'shared/flash', locals: { message: 'Erro ao criar manutenção.', type: 'error' })
        }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    respond_to do |format|
      if @equipment_maintenance.update(equipment_maintenance_params)
        format.turbo_stream { 
          render turbo_stream: [
            turbo_stream.replace(@equipment_maintenance, partial: 'equipment_maintenances/maintenance_frame', locals: { maintenance: @equipment_maintenance }),
            turbo_stream.update('flash', partial: 'shared/flash', locals: { message: 'Manutenção atualizada com sucesso!', type: 'success' })
          ]
        }
        format.html { redirect_to @equipment_maintenance, notice: 'Manutenção atualizada com sucesso!' }
      else
        format.turbo_stream { 
          render turbo_stream: turbo_stream.update('flash', partial: 'shared/flash', locals: { message: 'Erro ao atualizar manutenção.', type: 'error' })
        }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @equipment_maintenance.destroy
    
    respond_to do |format|
      format.turbo_stream { 
        render turbo_stream: [
          turbo_stream.remove(@equipment_maintenance),
          turbo_stream.update('flash', partial: 'shared/flash', locals: { message: 'Manutenção excluída com sucesso!', type: 'success' })
        ]
      }
      format.html { redirect_to equipment_maintenances_path, notice: 'Manutenção excluída com sucesso!' }
    end
  end
  
  private
  
  def set_equipment_maintenance
    @equipment_maintenance = current_tenant.equipment_maintenances.find(params[:id])
  end
  
  def equipment_maintenance_params
    params.require(:equipment_maintenance).permit(
      :equipment_id,
      :maintenance_type,
      :start_date,
      :due_date,
      :completion_date,
      :status,
      :priority,
      :labor_cost,
      :parts_cost,
      :other_costs,
      :description,
      :solution,
      :notes,
      equipment_maintenance_photos_attributes: [:id, :photo, :photo_type, :description, :_destroy],
      equipment_maintenance_documents_attributes: [:id, :document, :document_type, :description, :_destroy]
    )
  end
end 
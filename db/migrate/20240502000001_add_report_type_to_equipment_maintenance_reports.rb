class AddReportTypeToEquipmentMaintenanceReports < ActiveRecord::Migration[7.1]
  def change
    add_column :equipment_maintenance_reports, :report_type, :integer, null: false, default: 0
    add_index :equipment_maintenance_reports, :report_type
  end
end 
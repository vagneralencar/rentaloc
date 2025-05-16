# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_05_15_221110) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.string "addressable_type", null: false
    t.integer "addressable_id", null: false
    t.integer "address_type", default: 0
    t.string "street", null: false
    t.string "number", null: false
    t.string "complement"
    t.string "neighborhood", null: false
    t.string "city", null: false
    t.string "state", null: false
    t.string "zip_code", null: false
    t.text "notes"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "person_id"
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable"
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id"
    t.index ["tenant_id"], name: "index_addresses_on_tenant_id"
    t.index ["zip_code"], name: "index_addresses_on_zip_code"
  end

  create_table "bank_references", force: :cascade do |t|
    t.integer "person_id", null: false
    t.string "bank_name"
    t.string "agency"
    t.string "account"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_bank_references_on_person_id"
  end

  create_table "categories", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.string "name", null: false
    t.string "code", null: false
    t.text "description"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category_type"
    t.integer "parent_id"
    t.index ["tenant_id", "code"], name: "index_categories_on_tenant_id_and_code", unique: true
    t.index ["tenant_id"], name: "index_categories_on_tenant_id"
  end

  create_table "commercial_references", force: :cascade do |t|
    t.integer "person_id", null: false
    t.string "company_name"
    t.string "phone"
    t.string "attendant"
    t.date "first_purchase"
    t.decimal "largest_purchase"
    t.date "last_purchase"
    t.string "payment_method"
    t.string "observation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_commercial_references_on_person_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.string "contactable_type", null: false
    t.integer "contactable_id", null: false
    t.integer "contact_type", default: 0
    t.string "name", null: false
    t.string "email", null: false
    t.string "phone"
    t.string "position"
    t.text "notes"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contactable_type", "contactable_id"], name: "index_contacts_on_contactable"
    t.index ["contactable_type", "contactable_id"], name: "index_contacts_on_contactable_type_and_contactable_id"
    t.index ["email"], name: "index_contacts_on_email"
    t.index ["tenant_id"], name: "index_contacts_on_tenant_id"
  end

  create_table "cost_centers", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "parent_id"
    t.string "code", null: false
    t.string "name", null: false
    t.text "description"
    t.integer "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "budget"
    t.integer "category_id"
    t.index ["parent_id"], name: "index_cost_centers_on_parent_id"
    t.index ["status"], name: "index_cost_centers_on_status"
    t.index ["tenant_id", "code"], name: "index_cost_centers_on_tenant_id_and_code", unique: true
    t.index ["tenant_id"], name: "index_cost_centers_on_tenant_id"
  end

  create_table "credit_references", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "person_id", null: false
    t.integer "reference_type", null: false
    t.string "name", null: false
    t.string "contact_name", null: false
    t.string "phone", null: false
    t.text "additional_info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_credit_references_on_person_id"
    t.index ["reference_type"], name: "index_credit_references_on_reference_type"
    t.index ["tenant_id"], name: "index_credit_references_on_tenant_id"
  end

  create_table "custom_roles", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.string "name", null: false
    t.text "description"
    t.boolean "is_system", default: false
    t.json "additional_data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["is_system"], name: "index_custom_roles_on_is_system"
    t.index ["tenant_id", "name"], name: "index_custom_roles_on_tenant_id_and_name", unique: true
    t.index ["tenant_id"], name: "index_custom_roles_on_tenant_id"
  end

  create_table "customer_contacts", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "customer_id", null: false
    t.string "name", null: false
    t.string "position"
    t.string "department"
    t.string "email"
    t.string "phone"
    t.string "mobile_phone"
    t.boolean "is_main_contact", default: false
    t.boolean "receives_notifications", default: false
    t.text "notes"
    t.json "additional_data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_customer_contacts_on_customer_id"
    t.index ["is_main_contact"], name: "index_customer_contacts_on_is_main_contact"
    t.index ["tenant_id", "customer_id", "email"], name: "index_customer_contacts_on_tenant_id_and_customer_id_and_email", unique: true
    t.index ["tenant_id"], name: "index_customer_contacts_on_tenant_id"
  end

  create_table "customer_histories", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "customer_id", null: false
    t.integer "created_by_id", null: false
    t.string "historyable_type"
    t.integer "historyable_id"
    t.integer "history_type", null: false
    t.string "title", null: false
    t.text "description"
    t.json "additional_data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_customer_histories_on_created_by_id"
    t.index ["customer_id"], name: "index_customer_histories_on_customer_id"
    t.index ["historyable_type", "historyable_id"], name: "idx_on_historyable_type_historyable_id_12809eadb5"
    t.index ["historyable_type", "historyable_id"], name: "index_customer_histories_on_historyable"
    t.index ["tenant_id", "customer_id", "history_type"], name: "idx_on_tenant_id_customer_id_history_type_3b99fb7324"
    t.index ["tenant_id"], name: "index_customer_histories_on_tenant_id"
  end

  create_table "equipment_accessories", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "equipment_id", null: false
    t.integer "accessory_id", null: false
    t.integer "quantity", null: false
    t.integer "status", default: 0
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accessory_id"], name: "index_equipment_accessories_on_accessory_id"
    t.index ["equipment_id", "accessory_id"], name: "index_equipment_accessories_on_equipment_id_and_accessory_id", unique: true
    t.index ["equipment_id"], name: "index_equipment_accessories_on_equipment_id"
    t.index ["status"], name: "index_equipment_accessories_on_status"
    t.index ["tenant_id"], name: "index_equipment_accessories_on_tenant_id"
  end

  create_table "equipment_documents", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "equipment_id", null: false
    t.integer "document_type", default: 4
    t.text "description"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document_type"], name: "index_equipment_documents_on_document_type"
    t.index ["equipment_id"], name: "index_equipment_documents_on_equipment_id"
    t.index ["tenant_id"], name: "index_equipment_documents_on_tenant_id"
  end

  create_table "equipment_maintenance_alerts", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "equipment_id", null: false
    t.integer "created_by_id", null: false
    t.integer "equipment_maintenance_schedule_id"
    t.integer "alert_type", default: 0, null: false
    t.integer "status", default: 0, null: false
    t.integer "priority", default: 1, null: false
    t.string "message", null: false
    t.date "due_date", null: false
    t.text "notes"
    t.json "additional_data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alert_type"], name: "index_equipment_maintenance_alerts_on_alert_type"
    t.index ["created_by_id"], name: "index_equipment_maintenance_alerts_on_created_by_id"
    t.index ["due_date"], name: "index_equipment_maintenance_alerts_on_due_date"
    t.index ["equipment_id"], name: "index_equipment_maintenance_alerts_on_equipment_id"
    t.index ["equipment_maintenance_schedule_id"], name: "idx_on_equipment_maintenance_schedule_id_8895b4ae3a"
    t.index ["priority"], name: "index_equipment_maintenance_alerts_on_priority"
    t.index ["status"], name: "index_equipment_maintenance_alerts_on_status"
    t.index ["tenant_id"], name: "index_equipment_maintenance_alerts_on_tenant_id"
  end

  create_table "equipment_maintenance_documents", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "equipment_maintenance_id", null: false
    t.integer "document_type", default: 3
    t.text "description"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document_type"], name: "index_equipment_maintenance_documents_on_document_type"
    t.index ["equipment_maintenance_id"], name: "idx_on_equipment_maintenance_id_5e4f97f080"
    t.index ["tenant_id"], name: "index_equipment_maintenance_documents_on_tenant_id"
  end

  create_table "equipment_maintenance_histories", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "equipment_id", null: false
    t.integer "performed_by_id", null: false
    t.integer "equipment_maintenance_id"
    t.integer "maintenance_type", default: 0, null: false
    t.integer "status", default: 0, null: false
    t.date "maintenance_date", null: false
    t.text "description"
    t.text "notes"
    t.json "additional_data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_id"], name: "index_equipment_maintenance_histories_on_equipment_id"
    t.index ["equipment_maintenance_id"], name: "idx_on_equipment_maintenance_id_428885b4d8"
    t.index ["maintenance_date"], name: "index_equipment_maintenance_histories_on_maintenance_date"
    t.index ["maintenance_type"], name: "index_equipment_maintenance_histories_on_maintenance_type"
    t.index ["performed_by_id"], name: "index_equipment_maintenance_histories_on_performed_by_id"
    t.index ["status"], name: "index_equipment_maintenance_histories_on_status"
    t.index ["tenant_id"], name: "index_equipment_maintenance_histories_on_tenant_id"
  end

  create_table "equipment_maintenance_labors", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "equipment_maintenance_id", null: false
    t.integer "performed_by_id", null: false
    t.text "description", null: false
    t.decimal "hours", precision: 10, scale: 2, null: false
    t.decimal "hourly_rate", precision: 10, scale: 2, null: false
    t.decimal "total_amount", precision: 10, scale: 2, null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_maintenance_id"], name: "index_equipment_maintenance_labors_on_equipment_maintenance_id"
    t.index ["performed_by_id"], name: "index_equipment_maintenance_labors_on_performed_by_id"
    t.index ["tenant_id"], name: "index_equipment_maintenance_labors_on_tenant_id"
  end

  create_table "equipment_maintenance_notifications", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "equipment_maintenance_alert_id", null: false
    t.integer "user_id", null: false
    t.integer "notification_type", default: 0, null: false
    t.integer "status", default: 0, null: false
    t.string "message", null: false
    t.datetime "sent_at"
    t.datetime "read_at"
    t.text "error_message"
    t.json "additional_data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_maintenance_alert_id"], name: "idx_on_equipment_maintenance_alert_id_4918a764cd"
    t.index ["notification_type"], name: "index_equipment_maintenance_notifications_on_notification_type"
    t.index ["read_at"], name: "index_equipment_maintenance_notifications_on_read_at"
    t.index ["sent_at"], name: "index_equipment_maintenance_notifications_on_sent_at"
    t.index ["status"], name: "index_equipment_maintenance_notifications_on_status"
    t.index ["tenant_id"], name: "index_equipment_maintenance_notifications_on_tenant_id"
    t.index ["user_id"], name: "index_equipment_maintenance_notifications_on_user_id"
  end

  create_table "equipment_maintenance_other_costs", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "equipment_maintenance_id", null: false
    t.integer "cost_type", default: 3
    t.text "description", null: false
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cost_type"], name: "index_equipment_maintenance_other_costs_on_cost_type"
    t.index ["equipment_maintenance_id"], name: "idx_on_equipment_maintenance_id_8b61096055"
    t.index ["tenant_id"], name: "index_equipment_maintenance_other_costs_on_tenant_id"
  end

  create_table "equipment_maintenance_parts", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "equipment_maintenance_id", null: false
    t.string "name", null: false
    t.string "part_number"
    t.string "manufacturer"
    t.string "supplier"
    t.decimal "quantity", precision: 10, scale: 2, null: false
    t.decimal "unit_price", precision: 10, scale: 2, null: false
    t.decimal "total_price", precision: 10, scale: 2, null: false
    t.text "description"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_maintenance_id"], name: "index_equipment_maintenance_parts_on_equipment_maintenance_id"
    t.index ["manufacturer"], name: "index_equipment_maintenance_parts_on_manufacturer"
    t.index ["part_number"], name: "index_equipment_maintenance_parts_on_part_number"
    t.index ["supplier"], name: "index_equipment_maintenance_parts_on_supplier"
    t.index ["tenant_id"], name: "index_equipment_maintenance_parts_on_tenant_id"
  end

  create_table "equipment_maintenance_photos", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "equipment_maintenance_id", null: false
    t.integer "photo_type", default: 3
    t.text "description"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_maintenance_id"], name: "index_equipment_maintenance_photos_on_equipment_maintenance_id"
    t.index ["photo_type"], name: "index_equipment_maintenance_photos_on_photo_type"
    t.index ["tenant_id"], name: "index_equipment_maintenance_photos_on_tenant_id"
  end

  create_table "equipment_maintenance_reports", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "equipment_maintenance_id", null: false
    t.integer "created_by_id", null: false
    t.text "description", null: false
    t.text "findings"
    t.text "recommendations"
    t.text "notes"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "report_type", default: 0, null: false
    t.index ["created_by_id"], name: "index_equipment_maintenance_reports_on_created_by_id"
    t.index ["equipment_maintenance_id"], name: "idx_on_equipment_maintenance_id_2aef134fb9"
    t.index ["report_type"], name: "index_equipment_maintenance_reports_on_report_type"
    t.index ["status"], name: "index_equipment_maintenance_reports_on_status"
    t.index ["tenant_id"], name: "index_equipment_maintenance_reports_on_tenant_id"
  end

  create_table "equipment_maintenance_schedules", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "equipment_id", null: false
    t.integer "created_by_id", null: false
    t.integer "maintenance_type", null: false
    t.integer "frequency", null: false
    t.date "last_maintenance_date", null: false
    t.date "next_maintenance_date", null: false
    t.integer "status", default: 0
    t.text "description"
    t.text "notes"
    t.json "additional_data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_equipment_maintenance_schedules_on_created_by_id"
    t.index ["equipment_id"], name: "index_equipment_maintenance_schedules_on_equipment_id"
    t.index ["frequency"], name: "index_equipment_maintenance_schedules_on_frequency"
    t.index ["last_maintenance_date"], name: "index_equipment_maintenance_schedules_on_last_maintenance_date"
    t.index ["maintenance_type"], name: "index_equipment_maintenance_schedules_on_maintenance_type"
    t.index ["next_maintenance_date"], name: "index_equipment_maintenance_schedules_on_next_maintenance_date"
    t.index ["status"], name: "index_equipment_maintenance_schedules_on_status"
    t.index ["tenant_id"], name: "index_equipment_maintenance_schedules_on_tenant_id"
  end

  create_table "equipment_maintenances", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "equipment_id", null: false
    t.integer "created_by_id", null: false
    t.integer "maintenance_type", null: false
    t.date "start_date", null: false
    t.date "due_date"
    t.date "completion_date"
    t.integer "status", default: 0
    t.integer "priority", default: 1
    t.decimal "labor_cost", precision: 10, scale: 2
    t.decimal "parts_cost", precision: 10, scale: 2
    t.decimal "other_costs", precision: 10, scale: 2
    t.decimal "total_cost", precision: 10, scale: 2
    t.text "description"
    t.text "solution"
    t.text "notes"
    t.json "additional_data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_equipment_maintenances_on_created_by_id"
    t.index ["due_date"], name: "index_equipment_maintenances_on_due_date"
    t.index ["equipment_id"], name: "index_equipment_maintenances_on_equipment_id"
    t.index ["maintenance_type"], name: "index_equipment_maintenances_on_maintenance_type"
    t.index ["priority"], name: "index_equipment_maintenances_on_priority"
    t.index ["start_date"], name: "index_equipment_maintenances_on_start_date"
    t.index ["status"], name: "index_equipment_maintenances_on_status"
    t.index ["tenant_id"], name: "index_equipment_maintenances_on_tenant_id"
  end

  create_table "equipment_photos", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "equipment_id", null: false
    t.integer "photo_type", default: 3
    t.text "description"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_id"], name: "index_equipment_photos_on_equipment_id"
    t.index ["photo_type"], name: "index_equipment_photos_on_photo_type"
    t.index ["tenant_id"], name: "index_equipment_photos_on_tenant_id"
  end

  create_table "equipments", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "category_id"
    t.string "code", null: false
    t.string "name", null: false
    t.text "description"
    t.integer "status", default: 0
    t.integer "control_type", default: 0
    t.string "unit"
    t.decimal "depreciation_rate", precision: 5, scale: 2
    t.decimal "weight", precision: 10, scale: 2
    t.decimal "last_purchase_price", precision: 10, scale: 2
    t.date "last_purchase_date"
    t.decimal "sale_price", precision: 10, scale: 2
    t.decimal "indemnity_value", precision: 10, scale: 2
    t.string "brand"
    t.string "model"
    t.string "serial_number"
    t.string "documentation_url"
    t.string "ncm"
    t.string "cest"
    t.integer "origin"
    t.json "rental_prices", default: {}
    t.json "additional_data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_equipments_on_category_id"
    t.index ["control_type"], name: "index_equipments_on_control_type"
    t.index ["status"], name: "index_equipments_on_status"
    t.index ["tenant_id", "code"], name: "index_equipments_on_tenant_id_and_code", unique: true
    t.index ["tenant_id"], name: "index_equipments_on_tenant_id"
  end

  create_table "financial_allocations", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "financial_entry_id", null: false
    t.integer "financial_nature_id", null: false
    t.integer "cost_center_id", null: false
    t.decimal "percentage", precision: 5, scale: 2, null: false
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.text "notes"
    t.json "additional_data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cost_center_id"], name: "index_financial_allocations_on_cost_center_id"
    t.index ["financial_entry_id", "financial_nature_id", "cost_center_id"], name: "idx_financial_allocations_unique", unique: true
    t.index ["financial_entry_id"], name: "index_financial_allocations_on_financial_entry_id"
    t.index ["financial_nature_id"], name: "index_financial_allocations_on_financial_nature_id"
    t.index ["tenant_id"], name: "index_financial_allocations_on_tenant_id"
  end

  create_table "financial_entries", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "created_by_id", null: false
    t.integer "financial_nature_id", null: false
    t.integer "cost_center_id", null: false
    t.integer "tax_rule_id"
    t.date "entry_date", null: false
    t.date "due_date", null: false
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.string "description", null: false
    t.integer "entry_type", null: false
    t.integer "status", default: 0
    t.text "notes"
    t.json "additional_data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cost_center_id"], name: "index_financial_entries_on_cost_center_id"
    t.index ["created_by_id"], name: "index_financial_entries_on_created_by_id"
    t.index ["due_date"], name: "index_financial_entries_on_due_date"
    t.index ["entry_date"], name: "index_financial_entries_on_entry_date"
    t.index ["entry_type"], name: "index_financial_entries_on_entry_type"
    t.index ["financial_nature_id"], name: "index_financial_entries_on_financial_nature_id"
    t.index ["status"], name: "index_financial_entries_on_status"
    t.index ["tax_rule_id"], name: "index_financial_entries_on_tax_rule_id"
    t.index ["tenant_id"], name: "index_financial_entries_on_tenant_id"
  end

  create_table "financial_entry_allocations", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "financial_entry_id", null: false
    t.integer "financial_nature_id", null: false
    t.integer "cost_center_id", null: false
    t.decimal "percentage", precision: 5, scale: 2, null: false
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.text "notes"
    t.json "additional_data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cost_center_id"], name: "index_financial_entry_allocations_on_cost_center_id"
    t.index ["financial_entry_id", "financial_nature_id", "cost_center_id"], name: "idx_financial_entry_allocations_unique", unique: true
    t.index ["financial_entry_id"], name: "index_financial_entry_allocations_on_financial_entry_id"
    t.index ["financial_nature_id"], name: "index_financial_entry_allocations_on_financial_nature_id"
    t.index ["tenant_id"], name: "index_financial_entry_allocations_on_tenant_id"
  end

  create_table "financial_entry_payments", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "financial_entry_id", null: false
    t.integer "created_by_id", null: false
    t.date "payment_date", null: false
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.decimal "discount_amount", precision: 10, scale: 2, default: "0.0"
    t.decimal "addition_amount", precision: 10, scale: 2, default: "0.0"
    t.decimal "net_amount", precision: 10, scale: 2, null: false
    t.integer "payment_method", null: false
    t.string "document_number"
    t.text "notes"
    t.json "additional_data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_financial_entry_payments_on_created_by_id"
    t.index ["financial_entry_id"], name: "index_financial_entry_payments_on_financial_entry_id"
    t.index ["payment_date"], name: "index_financial_entry_payments_on_payment_date"
    t.index ["payment_method"], name: "index_financial_entry_payments_on_payment_method"
    t.index ["tenant_id"], name: "index_financial_entry_payments_on_tenant_id"
  end

  create_table "financial_natures", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "parent_id"
    t.string "code", null: false
    t.string "name", null: false
    t.text "description"
    t.integer "status", null: false
    t.integer "nature_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nature_type"], name: "index_financial_natures_on_nature_type"
    t.index ["parent_id"], name: "index_financial_natures_on_parent_id"
    t.index ["status"], name: "index_financial_natures_on_status"
    t.index ["tenant_id", "code"], name: "index_financial_natures_on_tenant_id_and_code", unique: true
    t.index ["tenant_id"], name: "index_financial_natures_on_tenant_id"
  end

  create_table "financial_payments", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "financial_entry_id", null: false
    t.integer "created_by_id", null: false
    t.date "payment_date", null: false
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.integer "payment_method", null: false
    t.string "document_number"
    t.text "notes"
    t.json "additional_data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_financial_payments_on_created_by_id"
    t.index ["financial_entry_id", "payment_date"], name: "idx_on_financial_entry_id_payment_date_fc2815c5bd"
    t.index ["financial_entry_id"], name: "index_financial_payments_on_financial_entry_id"
    t.index ["payment_method"], name: "index_financial_payments_on_payment_method"
    t.index ["tenant_id"], name: "index_financial_payments_on_tenant_id"
  end

  create_table "financial_reports", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "created_by_id", null: false
    t.string "name", null: false
    t.string "code", null: false
    t.string "category", null: false
    t.text "description"
    t.json "parameters", default: {}
    t.json "filters", default: {}
    t.json "output_format", default: {}
    t.boolean "is_system", default: false
    t.boolean "is_active", default: true
    t.json "additional_data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_financial_reports_on_category"
    t.index ["created_by_id"], name: "index_financial_reports_on_created_by_id"
    t.index ["is_active"], name: "index_financial_reports_on_is_active"
    t.index ["is_system"], name: "index_financial_reports_on_is_system"
    t.index ["tenant_id", "code"], name: "index_financial_reports_on_tenant_id_and_code", unique: true
    t.index ["tenant_id"], name: "index_financial_reports_on_tenant_id"
  end

  create_table "financial_status_histories", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "financial_entry_id", null: false
    t.integer "created_by_id", null: false
    t.integer "status", null: false
    t.integer "previous_status"
    t.text "notes"
    t.json "additional_data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_financial_status_histories_on_created_at"
    t.index ["created_by_id"], name: "index_financial_status_histories_on_created_by_id"
    t.index ["financial_entry_id", "status"], name: "idx_on_financial_entry_id_status_122e894c74"
    t.index ["financial_entry_id"], name: "index_financial_status_histories_on_financial_entry_id"
    t.index ["tenant_id"], name: "index_financial_status_histories_on_tenant_id"
  end

  create_table "observations", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.string "observable_type", null: false
    t.integer "observable_id", null: false
    t.integer "user_id", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_observations_on_created_at"
    t.index ["observable_type", "observable_id"], name: "index_observations_on_observable"
    t.index ["tenant_id", "observable_type", "observable_id"], name: "idx_observations_tenant_observable"
    t.index ["tenant_id"], name: "index_observations_on_tenant_id"
    t.index ["user_id"], name: "index_observations_on_user_id"
  end

  create_table "people", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "user_id"
    t.integer "person_type", null: false
    t.integer "role", null: false
    t.integer "status", null: false
    t.string "document", null: false
    t.string "name", null: false
    t.string "trade_name"
    t.string "email", null: false
    t.string "nfe_email"
    t.string "activity"
    t.string "region"
    t.string "referral"
    t.date "registration_date"
    t.date "validity_date"
    t.date "last_update"
    t.string "phone_commercial"
    t.string "phone_residential"
    t.string "phone_mobile"
    t.string "phone_financial"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "fiscal_email"
    t.string "fiscal_type"
    t.string "state_registration"
    t.string "municipal_registration"
    t.string "cnae"
    t.string "tax_regime"
    t.boolean "withhold_iss"
    t.boolean "withhold_inss"
    t.boolean "withhold_ir"
    t.boolean "withhold_pis_cofins_csll"
    t.index ["person_type"], name: "index_people_on_person_type"
    t.index ["region"], name: "index_people_on_region"
    t.index ["role"], name: "index_people_on_role"
    t.index ["status"], name: "index_people_on_status"
    t.index ["tenant_id", "document"], name: "index_people_on_tenant_id_and_document", unique: true
    t.index ["tenant_id", "email"], name: "index_people_on_tenant_id_and_email", unique: true
    t.index ["tenant_id"], name: "index_people_on_tenant_id"
    t.index ["user_id"], name: "index_people_on_user_id"
  end

  create_table "permissions", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.string "name", null: false
    t.string "action", null: false
    t.string "subject_class", null: false
    t.text "description"
    t.boolean "is_system", default: false
    t.json "additional_data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["action", "subject_class"], name: "index_permissions_on_action_and_subject_class"
    t.index ["is_system"], name: "index_permissions_on_is_system"
    t.index ["tenant_id", "name"], name: "index_permissions_on_tenant_id_and_name", unique: true
    t.index ["tenant_id"], name: "index_permissions_on_tenant_id"
  end

  create_table "person_documents", force: :cascade do |t|
    t.integer "person_id", null: false
    t.integer "tenant_id", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_person_documents_on_person_id"
    t.index ["tenant_id"], name: "index_person_documents_on_tenant_id"
  end

  create_table "price_table_items", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "price_table_id", null: false
    t.integer "equipment_id", null: false
    t.decimal "daily_price", precision: 10, scale: 2, null: false
    t.decimal "weekly_price", precision: 10, scale: 2
    t.decimal "biweekly_price", precision: 10, scale: 2
    t.decimal "monthly_price", precision: 10, scale: 2
    t.decimal "quarterly_price", precision: 10, scale: 2
    t.decimal "semester_price", precision: 10, scale: 2
    t.decimal "yearly_price", precision: 10, scale: 2
    t.decimal "minimum_daily_price", precision: 10, scale: 2
    t.integer "minimum_rental_days"
    t.json "additional_data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_id"], name: "index_price_table_items_on_equipment_id"
    t.index ["price_table_id", "equipment_id"], name: "index_price_table_items_on_price_table_id_and_equipment_id", unique: true
    t.index ["price_table_id"], name: "index_price_table_items_on_price_table_id"
    t.index ["tenant_id"], name: "index_price_table_items_on_tenant_id"
  end

  create_table "price_tables", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.string "code", null: false
    t.string "name", null: false
    t.text "description"
    t.date "start_date", null: false
    t.date "end_date"
    t.integer "status", default: 0
    t.decimal "default_markup", precision: 10, scale: 2
    t.json "additional_data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["end_date"], name: "index_price_tables_on_end_date"
    t.index ["start_date"], name: "index_price_tables_on_start_date"
    t.index ["status"], name: "index_price_tables_on_status"
    t.index ["tenant_id", "code"], name: "index_price_tables_on_tenant_id_and_code", unique: true
    t.index ["tenant_id"], name: "index_price_tables_on_tenant_id"
  end

  create_table "quotation_items", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "quotation_id", null: false
    t.integer "equipment_id", null: false
    t.decimal "quantity", precision: 10, scale: 2, null: false
    t.decimal "unit_price", precision: 10, scale: 2, null: false
    t.decimal "total_amount", precision: 10, scale: 2, null: false
    t.integer "period_type", null: false
    t.integer "period_quantity", null: false
    t.text "description"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_id"], name: "index_quotation_items_on_equipment_id"
    t.index ["quotation_id", "equipment_id"], name: "index_quotation_items_on_quotation_id_and_equipment_id", unique: true
    t.index ["quotation_id"], name: "index_quotation_items_on_quotation_id"
    t.index ["tenant_id"], name: "index_quotation_items_on_tenant_id"
  end

  create_table "quotations", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "customer_id", null: false
    t.integer "created_by_id", null: false
    t.string "number", null: false
    t.date "valid_until", null: false
    t.integer "status", default: 0
    t.decimal "total_amount", precision: 10, scale: 2, default: "0.0"
    t.text "description"
    t.text "terms_and_conditions"
    t.text "notes"
    t.json "additional_data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_quotations_on_created_by_id"
    t.index ["customer_id"], name: "index_quotations_on_customer_id"
    t.index ["status"], name: "index_quotations_on_status"
    t.index ["tenant_id", "number"], name: "index_quotations_on_tenant_id_and_number", unique: true
    t.index ["tenant_id"], name: "index_quotations_on_tenant_id"
    t.index ["valid_until"], name: "index_quotations_on_valid_until"
  end

  create_table "related_people", force: :cascade do |t|
    t.integer "person_id", null: false
    t.string "cpf_cnpj"
    t.string "name"
    t.string "relation_type"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_related_people_on_person_id"
  end

  create_table "rental_billing_items", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "rental_billing_id", null: false
    t.integer "rental_item_id", null: false
    t.integer "equipment_id", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.integer "days", null: false
    t.decimal "quantity", precision: 10, scale: 2, null: false
    t.decimal "unit_price", precision: 10, scale: 2, null: false
    t.decimal "total_amount", precision: 10, scale: 2, null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_id"], name: "index_rental_billing_items_on_equipment_id"
    t.index ["rental_billing_id", "equipment_id"], name: "idx_on_rental_billing_id_equipment_id_a854f2596c", unique: true
    t.index ["rental_billing_id", "rental_item_id"], name: "idx_on_rental_billing_id_rental_item_id_32e330c8b5", unique: true
    t.index ["rental_billing_id"], name: "index_rental_billing_items_on_rental_billing_id"
    t.index ["rental_item_id"], name: "index_rental_billing_items_on_rental_item_id"
    t.index ["tenant_id"], name: "index_rental_billing_items_on_tenant_id"
  end

  create_table "rental_billings", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "rental_id", null: false
    t.integer "created_by_id", null: false
    t.string "number", null: false
    t.date "billing_date", null: false
    t.date "due_date", null: false
    t.decimal "total_amount", precision: 10, scale: 2, null: false
    t.integer "status", default: 0
    t.integer "payment_method"
    t.date "payment_date"
    t.string "pdf_file"
    t.text "notes"
    t.json "additional_data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["billing_date"], name: "index_rental_billings_on_billing_date"
    t.index ["created_by_id"], name: "index_rental_billings_on_created_by_id"
    t.index ["due_date"], name: "index_rental_billings_on_due_date"
    t.index ["rental_id"], name: "index_rental_billings_on_rental_id"
    t.index ["status"], name: "index_rental_billings_on_status"
    t.index ["tenant_id", "number"], name: "index_rental_billings_on_tenant_id_and_number", unique: true
    t.index ["tenant_id"], name: "index_rental_billings_on_tenant_id"
  end

  create_table "rental_items", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "rental_id", null: false
    t.integer "equipment_id", null: false
    t.decimal "quantity", precision: 10, scale: 2, null: false
    t.decimal "unit_price", precision: 10, scale: 2, null: false
    t.decimal "total_price", precision: 10, scale: 2, null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_id"], name: "index_rental_items_on_equipment_id"
    t.index ["rental_id", "equipment_id"], name: "index_rental_items_on_rental_id_and_equipment_id", unique: true
    t.index ["rental_id"], name: "index_rental_items_on_rental_id"
    t.index ["tenant_id"], name: "index_rental_items_on_tenant_id"
  end

  create_table "rental_movement_items", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "rental_movement_id", null: false
    t.integer "rental_item_id", null: false
    t.integer "equipment_id", null: false
    t.decimal "quantity", precision: 10, scale: 2, null: false
    t.decimal "total_quantity", precision: 10, scale: 2, null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_id"], name: "index_rental_movement_items_on_equipment_id"
    t.index ["rental_item_id"], name: "index_rental_movement_items_on_rental_item_id"
    t.index ["rental_movement_id", "equipment_id"], name: "idx_on_rental_movement_id_equipment_id_c54d2a611d", unique: true
    t.index ["rental_movement_id", "rental_item_id"], name: "idx_on_rental_movement_id_rental_item_id_99473a339d", unique: true
    t.index ["rental_movement_id"], name: "index_rental_movement_items_on_rental_movement_id"
    t.index ["tenant_id"], name: "index_rental_movement_items_on_tenant_id"
  end

  create_table "rental_movements", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "rental_id", null: false
    t.integer "created_by_id", null: false
    t.integer "movement_type", null: false
    t.datetime "movement_date", null: false
    t.integer "status", default: 0
    t.string "document_number"
    t.text "notes"
    t.json "additional_data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_rental_movements_on_created_by_id"
    t.index ["movement_date"], name: "index_rental_movements_on_movement_date"
    t.index ["movement_type"], name: "index_rental_movements_on_movement_type"
    t.index ["rental_id", "movement_type"], name: "index_rental_movements_on_rental_id_and_movement_type"
    t.index ["rental_id"], name: "index_rental_movements_on_rental_id"
    t.index ["status"], name: "index_rental_movements_on_status"
    t.index ["tenant_id"], name: "index_rental_movements_on_tenant_id"
  end

  create_table "rental_status_histories", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "rental_id", null: false
    t.integer "created_by_id", null: false
    t.integer "status", null: false
    t.text "notes"
    t.json "additional_data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_rental_status_histories_on_created_by_id"
    t.index ["rental_id", "created_at"], name: "index_rental_status_histories_on_rental_id_and_created_at"
    t.index ["rental_id"], name: "index_rental_status_histories_on_rental_id"
    t.index ["status"], name: "index_rental_status_histories_on_status"
    t.index ["tenant_id"], name: "index_rental_status_histories_on_tenant_id"
  end

  create_table "rentals", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "customer_id", null: false
    t.integer "work_id", null: false
    t.integer "created_by_id", null: false
    t.integer "seller_id"
    t.integer "cost_center_id"
    t.integer "financial_nature_id"
    t.integer "price_table_id"
    t.string "number", null: false
    t.date "issue_date", null: false
    t.date "start_date", null: false
    t.date "first_billing_date", null: false
    t.integer "due_day", null: false
    t.date "expected_end_date"
    t.date "end_date"
    t.integer "status", default: 0
    t.string "payment_condition"
    t.string "payment_method"
    t.string "contact_name"
    t.string "contact_phone"
    t.string "contact_email"
    t.text "notes"
    t.json "additional_data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cost_center_id"], name: "index_rentals_on_cost_center_id"
    t.index ["created_by_id"], name: "index_rentals_on_created_by_id"
    t.index ["customer_id"], name: "index_rentals_on_customer_id"
    t.index ["end_date"], name: "index_rentals_on_end_date"
    t.index ["financial_nature_id"], name: "index_rentals_on_financial_nature_id"
    t.index ["issue_date"], name: "index_rentals_on_issue_date"
    t.index ["price_table_id"], name: "index_rentals_on_price_table_id"
    t.index ["seller_id"], name: "index_rentals_on_seller_id"
    t.index ["start_date"], name: "index_rentals_on_start_date"
    t.index ["status"], name: "index_rentals_on_status"
    t.index ["tenant_id", "number"], name: "index_rentals_on_tenant_id_and_number", unique: true
    t.index ["tenant_id"], name: "index_rentals_on_tenant_id"
    t.index ["work_id"], name: "index_rentals_on_work_id"
  end

  create_table "reports", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "created_by_id", null: false
    t.string "name", null: false
    t.string "code", null: false
    t.string "category", null: false
    t.text "description"
    t.text "query"
    t.json "parameters", default: {}
    t.json "output_format", default: {}
    t.boolean "is_system", default: false
    t.boolean "is_active", default: true
    t.json "additional_data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_reports_on_category"
    t.index ["created_by_id"], name: "index_reports_on_created_by_id"
    t.index ["is_active"], name: "index_reports_on_is_active"
    t.index ["is_system"], name: "index_reports_on_is_system"
    t.index ["tenant_id", "code"], name: "index_reports_on_tenant_id_and_code", unique: true
    t.index ["tenant_id"], name: "index_reports_on_tenant_id"
  end

  create_table "role_permissions", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "role_id", null: false
    t.integer "permission_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["permission_id"], name: "index_role_permissions_on_permission_id"
    t.index ["role_id", "permission_id"], name: "index_role_permissions_on_role_id_and_permission_id", unique: true
    t.index ["role_id"], name: "index_role_permissions_on_role_id"
    t.index ["tenant_id"], name: "index_role_permissions_on_tenant_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.integer "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
  end

  create_table "service_order_documents", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "service_order_id", null: false
    t.integer "document_type", default: 3
    t.text "description"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document_type"], name: "index_service_order_documents_on_document_type"
    t.index ["service_order_id"], name: "index_service_order_documents_on_service_order_id"
    t.index ["tenant_id"], name: "index_service_order_documents_on_tenant_id"
  end

  create_table "service_order_items", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "service_order_id", null: false
    t.integer "equipment_id", null: false
    t.decimal "quantity", precision: 10, scale: 2, null: false
    t.decimal "unit_price", precision: 10, scale: 2, null: false
    t.decimal "total_amount", precision: 10, scale: 2, null: false
    t.text "description"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_id"], name: "index_service_order_items_on_equipment_id"
    t.index ["service_order_id", "equipment_id"], name: "index_service_order_items_on_service_order_id_and_equipment_id", unique: true
    t.index ["service_order_id"], name: "index_service_order_items_on_service_order_id"
    t.index ["tenant_id"], name: "index_service_order_items_on_tenant_id"
  end

  create_table "service_order_materials", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "service_order_id", null: false
    t.integer "material_id", null: false
    t.decimal "quantity", precision: 10, scale: 2, null: false
    t.decimal "unit_price", precision: 10, scale: 2, null: false
    t.decimal "total_amount", precision: 10, scale: 2, null: false
    t.boolean "is_billable", default: true
    t.string "serial_number"
    t.text "description"
    t.text "notes"
    t.json "additional_data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["is_billable"], name: "index_service_order_materials_on_is_billable"
    t.index ["material_id"], name: "index_service_order_materials_on_material_id"
    t.index ["service_order_id", "material_id"], name: "idx_on_service_order_id_material_id_fc0bb4cf25", unique: true
    t.index ["service_order_id"], name: "index_service_order_materials_on_service_order_id"
    t.index ["tenant_id"], name: "index_service_order_materials_on_tenant_id"
  end

  create_table "service_order_photos", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "service_order_id", null: false
    t.integer "photo_type", default: 3
    t.text "description"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["photo_type"], name: "index_service_order_photos_on_photo_type"
    t.index ["service_order_id"], name: "index_service_order_photos_on_service_order_id"
    t.index ["tenant_id"], name: "index_service_order_photos_on_tenant_id"
  end

  create_table "service_order_services", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "service_order_id", null: false
    t.integer "service_id", null: false
    t.decimal "quantity", precision: 10, scale: 2, null: false
    t.decimal "unit_price", precision: 10, scale: 2, null: false
    t.decimal "total_amount", precision: 10, scale: 2, null: false
    t.boolean "is_billable", default: true
    t.text "description"
    t.text "notes"
    t.json "additional_data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["is_billable"], name: "index_service_order_services_on_is_billable"
    t.index ["service_id"], name: "index_service_order_services_on_service_id"
    t.index ["service_order_id", "service_id"], name: "idx_on_service_order_id_service_id_ca3521c760", unique: true
    t.index ["service_order_id"], name: "index_service_order_services_on_service_order_id"
    t.index ["tenant_id"], name: "index_service_order_services_on_tenant_id"
  end

  create_table "service_order_technicians", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "service_order_id", null: false
    t.integer "technician_id", null: false
    t.datetime "scheduled_start_at"
    t.datetime "scheduled_end_at"
    t.datetime "actual_start_at"
    t.datetime "actual_end_at"
    t.integer "status", default: 0
    t.text "notes"
    t.json "additional_data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_order_id", "technician_id"], name: "idx_service_order_technicians_unique", unique: true
    t.index ["service_order_id"], name: "index_service_order_technicians_on_service_order_id"
    t.index ["status"], name: "index_service_order_technicians_on_status"
    t.index ["technician_id"], name: "index_service_order_technicians_on_technician_id"
    t.index ["tenant_id"], name: "index_service_order_technicians_on_tenant_id"
  end

  create_table "service_orders", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "customer_id", null: false
    t.integer "created_by_id", null: false
    t.string "number", null: false
    t.date "start_date", null: false
    t.date "due_date"
    t.date "completion_date"
    t.integer "status", default: 0
    t.integer "priority", default: 1
    t.decimal "total_amount", precision: 10, scale: 2, default: "0.0"
    t.text "description"
    t.text "solution"
    t.text "notes"
    t.json "additional_data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_service_orders_on_created_by_id"
    t.index ["customer_id"], name: "index_service_orders_on_customer_id"
    t.index ["due_date"], name: "index_service_orders_on_due_date"
    t.index ["priority"], name: "index_service_orders_on_priority"
    t.index ["start_date"], name: "index_service_orders_on_start_date"
    t.index ["status"], name: "index_service_orders_on_status"
    t.index ["tenant_id", "number"], name: "index_service_orders_on_tenant_id_and_number", unique: true
    t.index ["tenant_id"], name: "index_service_orders_on_tenant_id"
  end

  create_table "service_requests", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "created_by_id", null: false
    t.integer "customer_id", null: false
    t.integer "equipment_id", null: false
    t.date "request_date", null: false
    t.text "description", null: false
    t.integer "priority", null: false
    t.integer "status", default: 0
    t.date "completion_date"
    t.text "notes"
    t.json "additional_data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["completion_date"], name: "index_service_requests_on_completion_date"
    t.index ["created_by_id"], name: "index_service_requests_on_created_by_id"
    t.index ["customer_id"], name: "index_service_requests_on_customer_id"
    t.index ["equipment_id"], name: "index_service_requests_on_equipment_id"
    t.index ["priority"], name: "index_service_requests_on_priority"
    t.index ["request_date"], name: "index_service_requests_on_request_date"
    t.index ["status"], name: "index_service_requests_on_status"
    t.index ["tenant_id"], name: "index_service_requests_on_tenant_id"
  end

  create_table "service_tax_rules", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "service_id"
  end

  create_table "services", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "category_id"
    t.string "code", null: false
    t.string "name", null: false
    t.text "description"
    t.integer "status", null: false
    t.string "unit", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.text "nfs_description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "service_type"
    t.index ["category_id"], name: "index_services_on_category_id"
    t.index ["status"], name: "index_services_on_status"
    t.index ["tenant_id", "code"], name: "index_services_on_tenant_id_and_code", unique: true
    t.index ["tenant_id"], name: "index_services_on_tenant_id"
    t.index ["unit"], name: "index_services_on_unit"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "user_id", null: false
    t.string "token", null: false
    t.datetime "expires_at"
    t.string "ip_address"
    t.string "user_agent"
    t.json "additional_data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expires_at"], name: "index_sessions_on_expires_at"
    t.index ["tenant_id"], name: "index_sessions_on_tenant_id"
    t.index ["token"], name: "index_sessions_on_token", unique: true
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "settings", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.string "key", null: false
    t.text "value"
    t.string "value_type", default: "string"
    t.text "description"
    t.boolean "is_system", default: false
    t.json "additional_data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["is_system"], name: "index_settings_on_is_system"
    t.index ["tenant_id", "key"], name: "index_settings_on_tenant_id_and_key", unique: true
    t.index ["tenant_id"], name: "index_settings_on_tenant_id"
  end

  create_table "tax_rules", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.string "taxable_type", null: false
    t.integer "taxable_id", null: false
    t.integer "tax_type", null: false
    t.decimal "rate", precision: 5, scale: 2, null: false
    t.decimal "calculation_base", precision: 5, scale: 2, null: false
    t.boolean "withholding", default: false, null: false
    t.string "fiscal_code", null: false
    t.text "fiscal_code_description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tax_type"], name: "index_tax_rules_on_tax_type"
    t.index ["taxable_type", "taxable_id"], name: "index_tax_rules_on_taxable"
    t.index ["tenant_id", "taxable_type", "taxable_id", "tax_type"], name: "idx_tax_rules_unique", unique: true
    t.index ["tenant_id"], name: "index_tax_rules_on_tenant_id"
    t.index ["withholding"], name: "index_tax_rules_on_withholding"
  end

  create_table "tenant_onboarding_statuses", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "status", default: 0
    t.datetime "started_at"
    t.datetime "completed_at"
    t.json "completed_steps", default: {}
    t.json "pending_steps", default: {}
    t.text "notes"
    t.json "additional_data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["completed_at"], name: "index_tenant_onboarding_statuses_on_completed_at"
    t.index ["started_at"], name: "index_tenant_onboarding_statuses_on_started_at"
    t.index ["status"], name: "index_tenant_onboarding_statuses_on_status"
    t.index ["tenant_id"], name: "index_tenant_onboarding_statuses_on_tenant_id"
  end

  create_table "tenant_onboarding_steps", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.string "code", null: false
    t.string "name", null: false
    t.text "description"
    t.integer "order", null: false
    t.boolean "required", default: true
    t.boolean "completed", default: false
    t.datetime "completed_at"
    t.json "data", default: {}
    t.json "validation_rules", default: {}
    t.json "additional_data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["completed"], name: "index_tenant_onboarding_steps_on_completed"
    t.index ["order"], name: "index_tenant_onboarding_steps_on_order"
    t.index ["tenant_id", "code"], name: "index_tenant_onboarding_steps_on_tenant_id_and_code", unique: true
    t.index ["tenant_id"], name: "index_tenant_onboarding_steps_on_tenant_id"
  end

  create_table "tenant_onboarding_templates", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.text "description"
    t.json "default_settings", default: {}
    t.json "default_steps", default: {}
    t.json "default_roles", default: {}
    t.json "default_permissions", default: {}
    t.boolean "is_active", default: true
    t.json "additional_data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_tenant_onboarding_templates_on_code", unique: true
    t.index ["is_active"], name: "index_tenant_onboarding_templates_on_is_active"
  end

  create_table "tenants", force: :cascade do |t|
    t.string "name", null: false
    t.string "cnpj", null: false
    t.string "email", null: false
    t.string "phone"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.string "logo"
    t.json "settings", default: {}
    t.boolean "active", default: true
    t.datetime "trial_ends_at"
    t.datetime "subscription_ends_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0, null: false
    t.integer "tax_regime"
    t.string "subdomain"
    t.string "corporate_name"
    t.index ["cnpj"], name: "index_tenants_on_cnpj", unique: true
    t.index ["email"], name: "index_tenants_on_email", unique: true
    t.index ["status"], name: "index_tenants_on_status"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "name", null: false
    t.string "phone"
    t.integer "role", default: 2
    t.integer "tenant_id", null: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["tenant_id"], name: "index_users_on_tenant_id"
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  create_table "works", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.string "code", null: false
    t.string "name", null: false
    t.text "description"
    t.integer "status", null: false
    t.date "start_date", null: false
    t.date "expected_end_date", null: false
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "work_type"
    t.integer "person_id"
    t.index ["end_date"], name: "index_works_on_end_date"
    t.index ["expected_end_date"], name: "index_works_on_expected_end_date"
    t.index ["start_date"], name: "index_works_on_start_date"
    t.index ["status"], name: "index_works_on_status"
    t.index ["tenant_id", "code"], name: "index_works_on_tenant_id_and_code", unique: true
    t.index ["tenant_id"], name: "index_works_on_tenant_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "addresses", "tenants"
  add_foreign_key "bank_references", "people"
  add_foreign_key "categories", "tenants"
  add_foreign_key "commercial_references", "people"
  add_foreign_key "contacts", "tenants"
  add_foreign_key "cost_centers", "cost_centers", column: "parent_id"
  add_foreign_key "cost_centers", "tenants"
  add_foreign_key "credit_references", "people"
  add_foreign_key "credit_references", "tenants"
  add_foreign_key "custom_roles", "tenants"
  add_foreign_key "customer_contacts", "customers"
  add_foreign_key "customer_contacts", "tenants"
  add_foreign_key "customer_histories", "customers"
  add_foreign_key "customer_histories", "tenants"
  add_foreign_key "customer_histories", "users", column: "created_by_id"
  add_foreign_key "equipment_accessories", "equipment"
  add_foreign_key "equipment_accessories", "equipments", column: "accessory_id"
  add_foreign_key "equipment_accessories", "tenants"
  add_foreign_key "equipment_documents", "equipment"
  add_foreign_key "equipment_documents", "tenants"
  add_foreign_key "equipment_maintenance_alerts", "equipment"
  add_foreign_key "equipment_maintenance_alerts", "equipment_maintenance_schedules"
  add_foreign_key "equipment_maintenance_alerts", "tenants"
  add_foreign_key "equipment_maintenance_alerts", "users", column: "created_by_id"
  add_foreign_key "equipment_maintenance_documents", "equipment_maintenances"
  add_foreign_key "equipment_maintenance_documents", "tenants"
  add_foreign_key "equipment_maintenance_histories", "equipment"
  add_foreign_key "equipment_maintenance_histories", "equipment_maintenances"
  add_foreign_key "equipment_maintenance_histories", "tenants"
  add_foreign_key "equipment_maintenance_histories", "users", column: "performed_by_id"
  add_foreign_key "equipment_maintenance_labors", "equipment_maintenances"
  add_foreign_key "equipment_maintenance_labors", "tenants"
  add_foreign_key "equipment_maintenance_labors", "users", column: "performed_by_id"
  add_foreign_key "equipment_maintenance_notifications", "equipment_maintenance_alerts"
  add_foreign_key "equipment_maintenance_notifications", "tenants"
  add_foreign_key "equipment_maintenance_notifications", "users"
  add_foreign_key "equipment_maintenance_other_costs", "equipment_maintenances"
  add_foreign_key "equipment_maintenance_other_costs", "tenants"
  add_foreign_key "equipment_maintenance_parts", "equipment_maintenances"
  add_foreign_key "equipment_maintenance_parts", "tenants"
  add_foreign_key "equipment_maintenance_photos", "equipment_maintenances"
  add_foreign_key "equipment_maintenance_photos", "tenants"
  add_foreign_key "equipment_maintenance_reports", "equipment_maintenances"
  add_foreign_key "equipment_maintenance_reports", "tenants"
  add_foreign_key "equipment_maintenance_reports", "users", column: "created_by_id"
  add_foreign_key "equipment_maintenance_schedules", "equipment"
  add_foreign_key "equipment_maintenance_schedules", "tenants"
  add_foreign_key "equipment_maintenance_schedules", "users", column: "created_by_id"
  add_foreign_key "equipment_maintenances", "equipment"
  add_foreign_key "equipment_maintenances", "tenants"
  add_foreign_key "equipment_maintenances", "users", column: "created_by_id"
  add_foreign_key "equipment_photos", "equipment"
  add_foreign_key "equipment_photos", "tenants"
  add_foreign_key "equipments", "categories"
  add_foreign_key "equipments", "tenants"
  add_foreign_key "financial_allocations", "cost_centers"
  add_foreign_key "financial_allocations", "financial_entries"
  add_foreign_key "financial_allocations", "financial_natures"
  add_foreign_key "financial_allocations", "tenants"
  add_foreign_key "financial_entries", "cost_centers"
  add_foreign_key "financial_entries", "financial_natures"
  add_foreign_key "financial_entries", "tax_rules"
  add_foreign_key "financial_entries", "tenants"
  add_foreign_key "financial_entries", "users", column: "created_by_id"
  add_foreign_key "financial_entry_allocations", "cost_centers"
  add_foreign_key "financial_entry_allocations", "financial_entries"
  add_foreign_key "financial_entry_allocations", "financial_natures"
  add_foreign_key "financial_entry_allocations", "tenants"
  add_foreign_key "financial_entry_payments", "financial_entries"
  add_foreign_key "financial_entry_payments", "tenants"
  add_foreign_key "financial_entry_payments", "users", column: "created_by_id"
  add_foreign_key "financial_natures", "financial_natures", column: "parent_id"
  add_foreign_key "financial_natures", "tenants"
  add_foreign_key "financial_payments", "financial_entries"
  add_foreign_key "financial_payments", "tenants"
  add_foreign_key "financial_payments", "users", column: "created_by_id"
  add_foreign_key "financial_reports", "tenants"
  add_foreign_key "financial_reports", "users", column: "created_by_id"
  add_foreign_key "financial_status_histories", "financial_entries"
  add_foreign_key "financial_status_histories", "tenants"
  add_foreign_key "financial_status_histories", "users", column: "created_by_id"
  add_foreign_key "observations", "tenants"
  add_foreign_key "observations", "users"
  add_foreign_key "people", "tenants"
  add_foreign_key "people", "users"
  add_foreign_key "permissions", "tenants"
  add_foreign_key "person_documents", "people"
  add_foreign_key "person_documents", "tenants"
  add_foreign_key "price_table_items", "equipment"
  add_foreign_key "price_table_items", "price_tables"
  add_foreign_key "price_table_items", "tenants"
  add_foreign_key "price_tables", "tenants"
  add_foreign_key "quotation_items", "equipment"
  add_foreign_key "quotation_items", "quotations"
  add_foreign_key "quotation_items", "tenants"
  add_foreign_key "quotations", "customers"
  add_foreign_key "quotations", "tenants"
  add_foreign_key "quotations", "users", column: "created_by_id"
  add_foreign_key "related_people", "people"
  add_foreign_key "rental_billing_items", "equipment"
  add_foreign_key "rental_billing_items", "rental_billings"
  add_foreign_key "rental_billing_items", "rental_items"
  add_foreign_key "rental_billing_items", "tenants"
  add_foreign_key "rental_billings", "rentals"
  add_foreign_key "rental_billings", "tenants"
  add_foreign_key "rental_billings", "users", column: "created_by_id"
  add_foreign_key "rental_items", "equipment"
  add_foreign_key "rental_items", "rentals"
  add_foreign_key "rental_items", "tenants"
  add_foreign_key "rental_movement_items", "equipment"
  add_foreign_key "rental_movement_items", "rental_items"
  add_foreign_key "rental_movement_items", "rental_movements"
  add_foreign_key "rental_movement_items", "tenants"
  add_foreign_key "rental_movements", "rentals"
  add_foreign_key "rental_movements", "tenants"
  add_foreign_key "rental_movements", "users", column: "created_by_id"
  add_foreign_key "rental_status_histories", "rentals"
  add_foreign_key "rental_status_histories", "tenants"
  add_foreign_key "rental_status_histories", "users", column: "created_by_id"
  add_foreign_key "rentals", "cost_centers"
  add_foreign_key "rentals", "financial_natures"
  add_foreign_key "rentals", "people", column: "customer_id"
  add_foreign_key "rentals", "price_tables"
  add_foreign_key "rentals", "tenants"
  add_foreign_key "rentals", "users", column: "created_by_id"
  add_foreign_key "rentals", "users", column: "seller_id"
  add_foreign_key "rentals", "works"
  add_foreign_key "reports", "tenants"
  add_foreign_key "reports", "users", column: "created_by_id"
  add_foreign_key "role_permissions", "permissions"
  add_foreign_key "role_permissions", "roles"
  add_foreign_key "role_permissions", "tenants"
  add_foreign_key "service_order_documents", "service_orders"
  add_foreign_key "service_order_documents", "tenants"
  add_foreign_key "service_order_items", "equipment"
  add_foreign_key "service_order_items", "service_orders"
  add_foreign_key "service_order_items", "tenants"
  add_foreign_key "service_order_materials", "materials"
  add_foreign_key "service_order_materials", "service_orders"
  add_foreign_key "service_order_materials", "tenants"
  add_foreign_key "service_order_photos", "service_orders"
  add_foreign_key "service_order_photos", "tenants"
  add_foreign_key "service_order_services", "service_orders"
  add_foreign_key "service_order_services", "services"
  add_foreign_key "service_order_services", "tenants"
  add_foreign_key "service_order_technicians", "service_orders"
  add_foreign_key "service_order_technicians", "tenants"
  add_foreign_key "service_order_technicians", "users", column: "technician_id"
  add_foreign_key "service_orders", "customers"
  add_foreign_key "service_orders", "tenants"
  add_foreign_key "service_orders", "users", column: "created_by_id"
  add_foreign_key "service_requests", "customers"
  add_foreign_key "service_requests", "equipment"
  add_foreign_key "service_requests", "tenants"
  add_foreign_key "service_requests", "users", column: "created_by_id"
  add_foreign_key "services", "categories"
  add_foreign_key "services", "tenants"
  add_foreign_key "sessions", "tenants"
  add_foreign_key "sessions", "users"
  add_foreign_key "settings", "tenants"
  add_foreign_key "tax_rules", "tenants"
  add_foreign_key "tenant_onboarding_statuses", "tenants"
  add_foreign_key "tenant_onboarding_steps", "tenants"
  add_foreign_key "users", "tenants"
  add_foreign_key "works", "tenants"
end

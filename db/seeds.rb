# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Limpar dados existentes
puts "Limpando dados existentes..."
[
  RentalBillingItem, RentalBilling, RentalMovementItem, RentalMovement,
  RentalItem, Rental, ServiceOrderItem, ServiceOrder, EquipmentMaintenanceReport,
  EquipmentMaintenanceNotification, EquipmentMaintenanceAlert, EquipmentMaintenanceHistory,
  EquipmentMaintenanceSchedule, EquipmentMaintenanceOtherCost, EquipmentMaintenancePart,
  EquipmentMaintenanceLabor, EquipmentMaintenanceDocument, EquipmentMaintenancePhoto,
  EquipmentMaintenance, EquipmentDocument, EquipmentAccessory, EquipmentPhoto, CreditReference, FinancialNature, CostCenter,
  TaxRule, Service, Work, Person, User, Category, Tenant
].each do |model|
  model.destroy_all
  puts "Registros de #{model.name} excluídos."
end

# Criação do Tenant inicial
begin
  tenant = Tenant.create!(
    name: 'Empresa Demonstração',
    cnpj: '25.216.909/0001-02',
    email: 'demo@gestaoloc.com.br',
    phone: '(00) 0000-0000',
    subdomain: 'demo',
    corporate_name: 'Empresa Demonstração LTDA'
  )
rescue ActiveRecord::RecordInvalid => e
  puts "Erro ao criar Tenant: #{e.record.errors.full_messages.join(', ')}"
  raise
end

# Criação do usuário administrador
User.find_or_create_by!(email: 'admin@gestaoloc.com.br') do |user|
  user.name = 'Administrador'
  user.password = 'password'
  user.password_confirmation = 'password'
  user.tenant = tenant
  user.add_role :admin
end

# Criar categorias
puts "Criando categorias..."
categories = [
  { name: 'Equipamentos Pesados', code: 'CAT001' },
  { name: 'Ferramentas Manuais', code: 'CAT002' },
  { name: 'Equipamentos Elétricos', code: 'CAT003' },
  { name: 'Andaimes e Escadas', code: 'CAT004' },
  { name: 'Compressores', code: 'CAT005' }
].map do |category|
  begin
    Category.create!(category.merge(tenant: tenant))
  rescue ActiveRecord::RecordInvalid => e
    puts "Erro ao criar categoria #{category[:name]}: #{e.record.errors.full_messages.join(', ')}"
    raise
  end
end

# Criar centros de custo
puts "Criando centros de custo..."
category = Category.first
cost_centers = [
  { name: 'Administrativo', code: 'CC001' },
  { name: 'Comercial', code: 'CC002' },
  { name: 'Operacional', code: 'CC003' },
  { name: 'Manutenção', code: 'CC004' },
  { name: 'Financeiro', code: 'CC005' }
].map do |cc|
  begin
    CostCenter.create!(cc.merge(tenant: tenant, status: :active, category: category))
  rescue ActiveRecord::RecordInvalid => e
    puts "Erro ao criar centro de custo #{cc[:name]}: #{e.record.errors.full_messages.join(', ')}"
    puts e.backtrace.first(10)
    raise
  end
end

# Criar naturezas financeiras
puts "Criando naturezas financeiras..."

# Receitas
revenue_natures = [
  { name: 'Receita de Locação', code: 'R001', nature_type: :revenue },
  { name: 'Receita de Serviços', code: 'R002', nature_type: :revenue }
].map do |fn|
  FinancialNature.create!(fn.merge(tenant: tenant, status: :active))
end

# Despesas
expense_natures = [
  { name: 'Despesa com Manutenção', code: 'D001', nature_type: :expense },
  { name: 'Despesa com Pessoal', code: 'D002', nature_type: :expense },
  { name: 'Despesa Administrativa', code: 'D003', nature_type: :expense }
].map do |fn|
  FinancialNature.create!(fn.merge(tenant: tenant, status: :active))
end

# Criar serviços
puts "Criando serviços..."
services = [
  { name: 'Manutenção Preventiva', code: 'SERV001', unit: 'UN', price: 150.00 },
  { name: 'Manutenção Corretiva', code: 'SERV002', unit: 'HR', price: 200.00 },
  { name: 'Instalação', code: 'SERV003', unit: 'UN', price: 300.00 },
  { name: 'Treinamento', code: 'SERV004', unit: 'HR', price: 250.00 },
  { name: 'Consultoria', code: 'SERV005', unit: 'HR', price: 180.00 }
].map do |service|
  Service.create!(
    service.merge(
      tenant: tenant,
      status: :active,
      nfs_description: "Prestação de serviço de #{service[:name].downcase}"
    )
  )
end

# Criar clientes
puts "Criando clientes..."
customers = [
  {
    name: 'Construtora ABC',
    trade_name: 'ABC Construções',
    document: '00000000000191',
    email: 'contato@abc.com.br',
    nfe_email: 'fiscal@abc.com.br',
    person_type: :company,
    phone_commercial: '(11) 3333-3333',
    status: :active
  },
  {
    name: 'João da Silva',
    document: '00000000191',
    email: 'joao@email.com',
    person_type: :individual,
    phone_mobile: '(11) 99999-9999',
    status: :active
  }
].map do |customer|
  Customer.create!(
    customer.merge(
      tenant: tenant,
      registration_date: Date.current
    )
  )
end

# Criar fornecedores
puts "Criando fornecedores..."
suppliers = [
  {
    name: 'Fornecedor XYZ',
    trade_name: 'XYZ Peças',
    document: '00000000000192',
    email: 'contato@xyz.com.br',
    nfe_email: 'fiscal@xyz.com.br',
    person_type: :company,
    phone_commercial: '(11) 4444-4444',
    status: :active
  }
].map do |supplier|
  Supplier.create!(
    supplier.merge(
      tenant: tenant,
      registration_date: Date.current
    )
  )
end

# Criar transportadoras
puts "Criando transportadoras..."
carriers = [
  {
    name: 'Transportadora Fast',
    trade_name: 'Fast Transportes',
    document: '00000000000193',
    email: 'contato@fast.com.br',
    nfe_email: 'fiscal@fast.com.br',
    person_type: :company,
    phone_commercial: '(11) 5555-5555',
    status: :active
  }
].map do |carrier|
  Carrier.create!(
    carrier.merge(
      tenant: tenant,
      registration_date: Date.current
    )
  )
end

puts 'Seeds criados com sucesso!'
puts 'Credenciais do administrador:'
puts 'Email: admin@gestaoloc.com.br'
puts 'Senha: password'

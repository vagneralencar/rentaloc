class MigrateCustomersAndSuppliersToPeople < ActiveRecord::Migration[7.0]
  def up
    # Migra clientes
    if ActiveRecord::Base.connection.table_exists?(:customers)
      Customer.find_each do |customer|
        person = Person.new(
          name: customer.name,
          document: customer.document,
          email: customer.email,
          role: 'customer',
          tenant_id: customer.tenant_id
          # ...adicione outros campos relevantes...
        )
        unless person.save
          puts "Erro ao migrar customer ##{customer.id}: #{person.errors.full_messages.join(', ')}"
        end
        # Atualize as foreign keys em Rentals, etc.
        if ActiveRecord::Base.connection.column_exists?(:rentals, :customer_id)
          Rental.where(customer_id: customer.id).update_all(customer_id: person.id)
        end
      end
    end

    # Migra fornecedores
    if ActiveRecord::Base.connection.table_exists?(:suppliers)
      Supplier.find_each do |supplier|
        person = Person.new(
          name: supplier.name,
          document: supplier.document,
          email: supplier.email,
          role: 'supplier',
          tenant_id: supplier.tenant_id
          # ...adicione outros campos relevantes...
        )
        unless person.save
          puts "Erro ao migrar supplier ##{supplier.id}: #{person.errors.full_messages.join(', ')}"
        end
        # Atualize as foreign keys em compras, etc. (exemplo)
        # Purchase.where(supplier_id: supplier.id).update_all(supplier_id: person.id) if defined?(Purchase)
      end
    end
  end

  def down
    # Não implementado (migração irreversível)
  end
end

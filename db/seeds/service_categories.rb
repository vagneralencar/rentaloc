# Create default service categories
puts "Creating service categories..."

service_categories = [
  { name: "Manutenção", code: "SV-MAN" },
  { name: "Instalação", code: "SV-INS" },
  { name: "Transporte", code: "SV-TRA" },
  { name: "Consultoria", code: "SV-CON" },
  { name: "Treinamento", code: "SV-TRE" },
  { name: "Outros", code: "SV-OUT" }
]

service_categories.each do |category_attrs|
  Tenant.find_each do |tenant|
    category = tenant.categories.find_or_initialize_by(
      code: category_attrs[:code],
      category_type: :service
    )
    
    category.name = category_attrs[:name]
    
    if category.save
      print "."
    else
      puts "\nError creating category #{category_attrs[:name]} for tenant #{tenant.name}:"
      puts category.errors.full_messages
    end
  end
end

puts "\nService categories created!" 
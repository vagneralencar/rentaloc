
# config/initializers/check_inflections.rb
puts "-------------------------------------------------------------"
puts "DEBUGGING INFLECTIONS AT BOOT TIME:"
puts "ActiveSupport::Inflector.inflections.uncountables:"
# Acessar diretamente o array interno. Isso pode variar entre versões do Rails.
# Para Rails 7+, geralmente é:
if ActiveSupport::Inflector.inflections.respond_to?(:__getobj__) # Para Delegator
  puts ActiveSupport::Inflector.inflections.__getobj__.uncountables.inspect
else # Tentativa direta, caso não seja um Delegator
  puts ActiveSupport::Inflector.inflections.uncountables.inspect
end
puts "Is 'equipment' uncountable? #{'equipment'.pluralize == 'equipment' && 'equipment'.singularize == 'equipment'}"
puts "-------------------------------------------------------------"
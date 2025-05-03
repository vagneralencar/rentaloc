class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the user here
    user ||= User.new # guest user (not logged in)
    
    if user.has_role?(:admin)
      # Administrador tem acesso total
      can :manage, :all
    else
      # Usuário comum
      can :read, :all
      
      # Locações
      can [:create, :update], Rental do |rental|
        rental.tenant_id == user.tenant_id
      end
      
      # Financeiro
      can [:create, :read], FinancialEntry do |entry|
        entry.tenant_id == user.tenant_id
      end
      can :update, FinancialEntry do |entry|
        entry.tenant_id == user.tenant_id && entry.created_by_id == user.id
      end
      
      # Atendimentos
      can [:create, :read], ServiceRequest do |request|
        Current.tenant&.id == user.tenant_id
      end
      can :update, ServiceRequest do |request|
        Current.tenant&.id == user.tenant_id && request.created_by_id == user.id
      end
      
      # Ordens de Serviço
      can [:create, :read], ServiceOrder do |order|
        order.tenant_id == user.tenant_id
      end
      can :update, ServiceOrder do |order|
        order.tenant_id == user.tenant_id && 
        (order.created_by_id == user.id || user.has_role?(:technician))
      end
    end
  end
end 
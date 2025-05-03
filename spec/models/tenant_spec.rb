require 'rails_helper'

RSpec.describe Tenant, type: :model do
  subject { build(:tenant) }

  # Validações
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:subdomain) }
    it { should validate_uniqueness_of(:subdomain).case_insensitive }
    
    it 'não permite subdomínios reservados' do
      tenant = build(:tenant, subdomain: 'www')
      expect(tenant).not_to be_valid
      expect(tenant.errors[:subdomain]).to include('não pode ser usado')
    end
  end

  # Associações
  describe 'associations' do
    it { should have_many(:users).dependent(:destroy) }
    it { should have_many(:rentals).dependent(:destroy) }
    it { should have_many(:financial_entries).dependent(:destroy) }
    it { should have_many(:service_requests).dependent(:destroy) }
    it { should have_many(:service_orders).dependent(:destroy) }
  end

  # Callbacks
  describe 'callbacks' do
    it 'normaliza o subdomínio antes de salvar' do
      tenant = create(:tenant, subdomain: 'TeStE')
      expect(tenant.subdomain).to eq('teste')
    end
  end

  # Métodos de Instância
  describe '#active?' do
    it 'retorna true quando o tenant está ativo' do
      tenant = build(:tenant, active: true)
      expect(tenant.active?).to be true
    end

    it 'retorna false quando o tenant está inativo' do
      tenant = build(:tenant, active: false)
      expect(tenant.active?).to be false
    end
  end

  # Escopos
  describe 'scopes' do
    describe '.active' do
      it 'retorna apenas tenants ativos' do
        active = create(:tenant, active: true)
        inactive = create(:tenant, active: false)
        
        expect(described_class.active).to include(active)
        expect(described_class.active).not_to include(inactive)
      end
    end
  end
end 
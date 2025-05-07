class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  def index
    if params[:role].present?
      @people = Person.where(role: params[:role])
    else
      @people = Person.all
    end
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(person_params)
    build_single_credit_reference
    if @person.save
      redirect_to edit_person_path(@person), notice: 'Pessoa criada com sucesso.'
    else
      render :new
    end
  end

  def show
    # Exibe os detalhes de uma pessoa
  end

  def edit
  end

  def update
    build_single_credit_reference
    if @person.update(person_params)
      redirect_to edit_person_path(@person), notice: 'Pessoa atualizada com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @person.destroy
    redirect_to people_path, notice: 'Pessoa excluída com sucesso.'
  end

  def new_commercial_reference
    @person = Person.find(params[:id])
    @commercial_reference = @person.commercial_references.build
    render partial: 'people/commercial_reference_fields', locals: { commercial_reference: @commercial_reference, person: @person }
  end

  private

  def set_person
    @person = Person.find(params[:id])
  end

  def build_single_credit_reference
    if params[:person][:credit_reference].present?
      @person.credit_references.destroy_all if @person.persisted?
      @person.credit_references.build(params[:person][:credit_reference].permit(:reference_type, :name, :contact_name, :phone, :notes))
    end
  end

  def person_params
    params.require(:person).permit(
      :name, :person_type, :document, :trade_name, :status, :email, :fiscal_email, :activity, :region, :indication, :user_id, :phone_commercial, :phone_residential, :phone_mobile, :phone_financial,
      documents: [],
      commercial_references_attributes: [
        :id, :company_name, :phone, :attendant, :first_purchase, :largest_purchase, :last_purchase, :payment_method, :observation, :_destroy
      ],
      bank_references_attributes: [
        :id, :bank_name, :agency, :account, :phone, :_destroy
      ],
      related_people_attributes: [
        :id, :cpf_cnpj, :name, :relation_type, :active, :_destroy
      ]
    )
  end
end

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

  private

  def set_person
    @person = Person.find(params[:id])
  end

  def person_params
    params.require(:person).permit(:name, :person_type, :document, :trade_name, :status, :email, :fiscal_email, :activity, :region, :indication, :user_id, :phone_commercial, :phone_residential, :phone_mobile, :phone_financial)
  end
end

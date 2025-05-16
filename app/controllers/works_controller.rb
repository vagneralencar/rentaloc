class WorksController < ApplicationController
  before_action :set_work, only: [:show, :edit, :update, :destroy]

  def index
    @works = Work.all
  end

  def show
  end

  def new
    @work = Work.new
    @work.contacts.build
    @work.addresses.build
  end

  def edit
    @work.contacts.build if @work.contacts.empty?
    @work.addresses.build if @work.addresses.empty?
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      redirect_to @work, notice: 'Obra criada com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @work.update(work_params)
      redirect_to @work, notice: 'Obra atualizada com sucesso.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @work.destroy
    redirect_to works_url, notice: 'Obra excluída com sucesso.'
  end

  private

  def set_work
    @work = Work.find(params[:id])
  end

  def work_params
    params.require(:work).permit(
      :person_id,
      :name,
      :description,
      :status,
      :work_type,
      :start_date,
      :expected_end_date,
      :end_date,
      contacts_attributes: [:id, :name, :email, :phone, :contact_type, :_destroy],
      addresses_attributes: [:id, :street, :number, :complement, :neighborhood, :city, :state, :zip_code, :_destroy]
    )
  end
end 
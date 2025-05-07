class BankReferencesController < ApplicationController
  before_action :set_person

  def create
    @bank_reference = @person.bank_references.build(bank_reference_params)
    if @bank_reference.save
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "bank_references",
            partial: "people/bank_references_table",
            locals: { person: @person }
          )
        }
        format.html { redirect_to edit_person_path(@person), notice: 'Referência bancária adicionada.' }
      end
    else
      render partial: 'people/bank_reference_fields', locals: { bank_reference: @bank_reference, person: @person }, status: :unprocessable_entity
    end
  end

  def edit
    @bank_reference = @person.bank_references.find(params[:id])
    render partial: 'people/bank_reference_fields', locals: { bank_reference: @bank_reference, person: @person }
  end

  def update
    @bank_reference = @person.bank_references.find(params[:id])
    if @bank_reference.update(bank_reference_params)
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "bank_references",
            partial: "people/bank_references_table",
            locals: { person: @person }
          )
        }
        format.html { redirect_to edit_person_path(@person), notice: 'Referência bancária atualizada.' }
      end
    else
      render partial: 'people/bank_reference_fields', locals: { bank_reference: @bank_reference, person: @person }, status: :unprocessable_entity
    end
  end

  def destroy
    @bank_reference = @person.bank_references.find(params[:id])
    @bank_reference.destroy
    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace(
          "bank_references",
          partial: "people/bank_references_table",
          locals: { person: @person }
        )
      }
      format.html { redirect_to edit_person_path(@person), notice: 'Referência bancária removida.' }
    end
  end

  private

  def set_person
    @person = Person.find(params[:person_id])
  end

  def bank_reference_params
    params.require(:bank_reference).permit(:bank_name, :agency, :account, :phone)
  end
end

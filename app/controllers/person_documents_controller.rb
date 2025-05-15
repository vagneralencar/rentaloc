class PersonDocumentsController < ApplicationController
  before_action :set_person

  def create
    @person_document = @person.person_documents.build(person_document_params)
    @person_document.tenant = current_tenant if @person_document.respond_to?(:tenant=)
    if @person_document.save
      redirect_to edit_person_path(@person, aba: 'documentos'), notice: 'Documento anexado com sucesso.'
    else
      redirect_to edit_person_path(@person, aba: 'documentos'), alert: 'Erro ao anexar documento.'
    end
  end

  def destroy
    @person_document = @person.person_documents.find(params[:id])
    @person_document.destroy
    redirect_to edit_person_path(@person, aba: 'documentos'), notice: 'Documento removido com sucesso.'
  end

  private

  def set_person
    @person = Person.find(params[:person_id])
  end

  def person_document_params
    params.require(:person_document).permit(:description, :file)
  end
end 
class ContactsController < ApplicationController
  before_action :set_person

  def create
    @contact = @person.contacts.build(contact_params)
    if @contact.save
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "contacts",
            partial: "people/contacts_table",
            locals: { person: @person }
          )
        }
        format.html { redirect_to edit_person_path(@person), notice: 'Contato adicionado com sucesso.' }
      end
    else
      render partial: 'people/contact_fields', locals: { contact: @contact, person: @person }, status: :unprocessable_entity
    end
  end

  def edit
    @contact = @person.contacts.find(params[:id])
    render partial: 'people/contact_fields', locals: { contact: @contact, person: @person }
  end

  def update
    @contact = @person.contacts.find(params[:id])
    if @contact.update(contact_params)
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "contacts",
            partial: "people/contacts_table",
            locals: { person: @person }
          )
        }
        format.html { redirect_to edit_person_path(@person), notice: 'Contato atualizado com sucesso.' }
      end
    else
      render partial: 'people/contact_fields', locals: { contact: @contact, person: @person }, status: :unprocessable_entity
    end
  end

  def destroy
    @contact = @person.contacts.find(params[:id])
    @contact.destroy
    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace(
          "contacts",
          partial: "people/contacts_table",
          locals: { person: @person }
        )
      }
      format.html { redirect_to edit_person_path(@person), notice: 'Contato removido com sucesso.' }
    end
  end

  private

  def set_person
    @person = Person.find(params[:person_id])
  end

  def contact_params
    params.require(:contact).permit(:name, :email, :phone, :mobile, :department, :position, :birthday, :notes, :primary, :financial, :commercial)
  end
end

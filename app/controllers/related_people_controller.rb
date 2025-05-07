class RelatedPeopleController < ApplicationController
  before_action :set_person

  def create
    @related_person = @person.related_people.build(related_person_params)
    if @related_person.save
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "related_people",
            partial: "people/related_people_table",
            locals: { person: @person }
          )
        }
        format.html { redirect_to edit_person_path(@person), notice: 'Pessoa relacionada adicionada.' }
      end
    else
      render partial: 'people/related_person_fields', locals: { related_person: @related_person, person: @person }, status: :unprocessable_entity
    end
  end

  def edit
    @related_person = @person.related_people.find(params[:id])
    render partial: 'people/related_person_fields', locals: { related_person: @related_person, person: @person }
  end

  def update
    @related_person = @person.related_people.find(params[:id])
    if @related_person.update(related_person_params)
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "related_people",
            partial: "people/related_people_table",
            locals: { person: @person }
          )
        }
        format.html { redirect_to edit_person_path(@person), notice: 'Pessoa relacionada atualizada.' }
      end
    else
      render partial: 'people/related_person_fields', locals: { related_person: @related_person, person: @person }, status: :unprocessable_entity
    end
  end

  def destroy
    @related_person = @person.related_people.find(params[:id])
    @related_person.destroy
    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace(
          "related_people",
          partial: "people/related_people_table",
          locals: { person: @person }
        )
      }
      format.html { redirect_to edit_person_path(@person), notice: 'Pessoa relacionada removida.' }
    end
  end

  private

  def set_person
    @person = Person.find(params[:person_id])
  end

  def related_person_params
    params.require(:related_person).permit(:cpf_cnpj, :name, :relation_type, :active)
  end
end

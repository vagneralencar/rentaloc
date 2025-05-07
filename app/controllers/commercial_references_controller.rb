class CommercialReferencesController < ApplicationController
  before_action :set_person
  before_action :set_commercial_reference, only: [:edit, :update, :destroy]

  def new
    @commercial_reference = @person.commercial_references.build
    respond_to do |format|
      format.turbo_stream { 
        render turbo_stream: turbo_stream.replace("new_commercial_reference", 
          partial: "people/commercial_reference_form", 
          locals: { person: @person, commercial_reference: @commercial_reference }
        )
      }
      format.html
    end
  end

  def create
    @commercial_reference = @person.commercial_references.build(commercial_reference_params)

    respond_to do |format|
      if @commercial_reference.save
        format.turbo_stream { 
          render turbo_stream: [
            turbo_stream.append("commercial_references_table tbody", 
              partial: "people/commercial_reference", 
              locals: { person: @person, commercial_reference: @commercial_reference }
            ),
            turbo_stream.replace("new_commercial_reference", 
              partial: "people/commercial_reference_form", 
              locals: { person: @person }
            )
          ]
        }
        format.html { redirect_to edit_person_path(@person, aba: 'referencias'), notice: 'Referência comercial adicionada com sucesso.' }
      else
        format.turbo_stream { 
          render turbo_stream: turbo_stream.replace("new_commercial_reference", 
            partial: "people/commercial_reference_form", 
            locals: { person: @person, commercial_reference: @commercial_reference }
          )
        }
        format.html { render :new }
      end
    end
  end

  def edit
    respond_to do |format|
      format.turbo_stream { 
        render turbo_stream: turbo_stream.replace(dom_id(@commercial_reference), 
          partial: "people/commercial_reference_form", 
          locals: { person: @person, commercial_reference: @commercial_reference }
        )
      }
      format.html
    end
  end

  def update
    respond_to do |format|
      if @commercial_reference.update(commercial_reference_params)
        format.turbo_stream { 
          render turbo_stream: turbo_stream.replace(dom_id(@commercial_reference), 
            partial: "people/commercial_reference", 
            locals: { person: @person, commercial_reference: @commercial_reference }
          )
        }
        format.html { redirect_to edit_person_path(@person, aba: 'referencias'), notice: 'Referência comercial atualizada com sucesso.' }
      else
        format.turbo_stream { 
          render turbo_stream: turbo_stream.replace(dom_id(@commercial_reference), 
            partial: "people/commercial_reference_form", 
            locals: { person: @person, commercial_reference: @commercial_reference }
          )
        }
        format.html { render :edit }
      end
    end
  end

  def destroy
    @commercial_reference.destroy
    respond_to do |format|
      format.turbo_stream { 
        render turbo_stream: turbo_stream.remove(dom_id(@commercial_reference))
      }
      format.html { redirect_to edit_person_path(@person, aba: 'referencias'), notice: 'Referência comercial removida com sucesso.' }
    end
  end

  private

  def set_person
    @person = Person.find(params[:person_id])
  end

  def set_commercial_reference
    @commercial_reference = @person.commercial_references.find(params[:id])
  end

  def commercial_reference_params
    params.require(:commercial_reference).permit(:company_name, :phone, :attendant, :first_purchase, :largest_purchase, :last_purchase, :payment_method, :observation)
  end
end

class MedicationsController < ApplicationController
  def index
    @medications = Medication.all

    search_term = params[:search]
    if search_term
      @medications = medications.where("name iLIKE ?", "%#{search_term}%")
    end

    render 'index.json.jbuilder'
  end 

  def create
    medication = Medication.new(
                    name: params[:name],
    )
    if medication.save
      render json: {message: 'Medication created successfully'}, status: :created
    else 
      render json: {errors: medication.errors.full_messages}, status: :bad_request
    end
  end 

  def show
    @medication = Medication.find(params[:id])
    render 'show.json.jbuilder'
  end 

  def update
    @medication = Medication.find(params[:id])

    @medication.name = params[:name] || medication.name

    if @medication.save
      render 'show.json.jbuilder'
    else
      render json: {errors: medications.errors.full_messages}, status: :unprocessable_entity
    end
  end 

  def destroy
    @medication = Medication.find(params[:id])
    medication.destroy
    render json: {message: "Successfully destroyed medication ##{medication.id}"}
  end 
end

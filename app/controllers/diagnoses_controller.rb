class DiagnosesController < ApplicationController
  def index
    @diagnoses = Diagnosis.all

    search_term = params[:search]
    if search_term
      @diagnoses = diagnoses.where("name iLIKE ?", "%#{search_term}%")
    end

    render 'index.json.jbuilder'
  end 

  def create
    diagnosis = Diagnosis.new(
                    name: params[:name],
                    icd_10_code: params[:icd_10_code]
    )
    if diagnosis.save
      render json: {message: 'Diagnosis created successfully'}, status: :created
    else 
      render json: {errors: diagnosis.errors.full_messages}, status: :bad_request
    end
  end 

  def show
    @diagnosis = Diagnosis.find(params[:id])
    render 'show.json.jbuilder'
  end 

  def update
    @diagnosis = Diagnosis.find(params[:id])

    @diagnosis.name = params[:name] || diagnosis.name
    @diagnosis.icd_10_code = params[:icd_10_code] || diagnosis.icd_10_code

    if @diagnosis.save
      render 'show.json.jbuilder'
    else
      render json: {errors: diagnoses.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    @diagnosis = Diagnosis.find(params[:id])
    @diagnosis.destroy
    render json: {message: "Successfully destroyed diagnosis ##{diagnosis.id}"}
  end
end

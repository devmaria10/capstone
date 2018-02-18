class UserMedicationsController < ApplicationController
  # def index
  #   @usermedications = UserMedication.all

  #   search_term = params[:search]
  #   if search_term
  #     @usermedications = usermedications.where("user_id iLIKE ?", "%#{search_term}%")
  #   end 

  #   render 'index.json.jbuilder'
  # end

  def create
    usermedication = UserMedication.new(
                    diagnosis_id: params[:diagnosis_id],
                    medication_id: params[:medication_id],
                    user_id: params[:user_id],
                    dosage: params[:dosage],
                    doctor_id: params[:doctor_id],

    )
    if usermedication.save
      render json: {message: 'UserMedication created successfully'}, status: :created
    else 
      render json: {errors: usermedication.errors.full_messages}, status: :bad_request
    end
  end 

  # def show
  #   @usermedication = UserMedication.find(params[:id])
  #   render 'show.json.jbuilder'
  # end 

  def update
    @usermedication = UserMedication.find(params[:id])

    @usermedication.diagnosis_id = params[:diagnosis_id] || usermedication.diagnosis_id
    @usermedication.medication_id = params[:medication_id] || usermedication.medication_id
    @usermedication.user_id = params[:user_id] || usermedication.user_id
    @usermedication.dosage = params[:dosage] || usermedication.dosage
    @usermedication.doctor_id = params[:doctor_id] || usermedication.doctor_id


    if @usermedication.save
      render 'show.json.jbuilder'
    else
      render json: {errors: usermedications.errors.full_messages}, status: :unprocessable_entity
    end
  end 

  def destroy
    @usermedication = UserMedication.find(params[:id])
    usermedication.destroy
    render json: {message: "Successfully destroyed usermedication ##{usermedication.id}"}
  end 
end

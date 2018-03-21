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
    user_medication = UserMedication.new(
                    diagnosis_id: params[:diagnosis_id],
                    medication_id: params[:medication_id],
                    user_id: params[:user_id],
                    dosage: params[:dosage],
                    doctor_id: params[:doctor_id],

    )

    Timer.new()
    if user_medication.save
      render json: {message: 'UserMedication created successfully'}, status: :created
    else 
      render json: {errors: user_medication.errors.full_messages}, status: :bad_request
    end
  end 

  def show
    @user_medication = UserMedication.find(params[:id])
    render 'show.json.jbuilder'
  end 

  def update
    @user_medication = UserMedication.find(params[:id])

    @user_medication.diagnosis_id = params[:diagnosis_id] || @usermedication.diagnosis_id
    @user_medication.medication_id = params[:medication_id] || @usermedication.medication_id
    @user_medication.user_id = params[:user_id] || @usermedication.user_id
    @user_medication.dosage = params[:dosage] || @usermedication.dosage
    @user_medication.doctor_id = params[:doctor_id] || @usermedication.doctor_id


    if @user_medication.save
      render 'show.json.jbuilder'
    else
      render json: {errors: @user_medications.errors.full_messages}, status: :unprocessable_entity
    end
  end 

  def destroy
    @user_medication = UserMedication.find(params[:id])
    @user_medication.destroy
    render json: {message: "Successfully destroyed user medication ##{@user_medication.id}"}
  end 
end

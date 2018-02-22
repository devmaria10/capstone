class UsersController < ApplicationController
  def index
    @users = User.all

    search_term = params[:search]
    if search_term
      @users = users.where("first_name iLIKE ? OR last_name iLIKE ?", "%#{search_term}%", "%#{search_term}%")
    end
    
    render 'index.json.jbuilder'
  end 

  def create
    user = User.new(
                    first_name: params[:first_name],
                    last_name: params[:last_name],
                    dob: params[:dob],
                    street_address: params[:street_address],
                    city: params[:city],
                    state: params[:state],
                    zip: params[:zip],
                    phone_number: params[:phone_number],
                    email: params[:email]
    )
    if user.save
      render json: {message: 'User created successfully'}, status: :created
    else 
      render json: {errors: user.errors.full_messages}, status: :bad_request
    end
  end 

  def show
    @user = User.find(params[:id])
    render 'show.json.jbuilder'
  end 

  def update
    @user = User.find(params[:id])
    
    @user.first_name = params[:first_name] || user.first_name
    @user.last_name = params[:last_name] || user.last_name
    @user.dob = params[:dob] || user.dob
    @user.street_address = params[:street_address] || user.street_address
    @user.city = params[:city] || user.city
    @user.state = params[:state] || user.state
    @user.zip = params[:zip] || user.zip
    @user.phone_number = params[:phone_number] || user.phone_number
    @user.email = params[:email] || user.email
 
    if @user.save
      render 'show.json.jbuilder'
    else
      render json: {errors: user.errors.full_messages}, status: :unprocessable_entity
    end
  end 

  def destroy
    user = User.find(params[:id])
    user.destroy
    render json: {message: "Successfully destroyed user ##{user.id}"}
  end 
end
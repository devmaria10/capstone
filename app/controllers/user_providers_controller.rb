class UserProvidersController < ApplicationController
  # def index
  #   @userproviders = UserProvider.all

  #   search_term = params[:search]
  #   if search_term
  #     @userproviders = userproviders.where("user_id iLIKE ?", "%#{search_term}%")
  #   end 

  #   render 'index.json.jbuilder'
  # end

  def create
    userprovider = UserProvider.new(
                    user_id: params[:user_id],
                    provider_id: params[:provider_id]
    )
    if userprovider.save
      render json: {message: 'UserProvider created successfully'}, status: :created
    else 
      render json: {errors: userprovider.errors.full_messages}, status: :bad_request
    end
  end 

  # def show
  #   @userprovider = UserProvider.find(params[:id])
  #   render 'show.json.jbuilder'
  # end 

  def update
    @userprovider = UserProvider.find(params[:id])

    @userprovider.user_id = params[:user_id] || userprovider.user_id
    @userprovider.provider_id = params[:provider_id] || userprovider.provider_id

    if @userprovider.save
      render 'show.json.jbuilder'
    else
      render json: {errors: userproviders.errors.full_messages}, status: :unprocessable_entity
    end
  end 

  def destroy
    @userprovider = UserProvider.find(params[:id])
    userprovider.destroy
    render json: {message: "Successfully destroyed userprovider ##{userprovider.id}"}
  end
end

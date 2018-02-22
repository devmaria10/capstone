class ProvidersController < ApplicationController
  def index
    @providers = Provider.all

    search_term = params[:search]
    if search_term
      @providers = providers.where("name iLIKE ?", "%#{search_term}%")
    end 

    render 'index.json.jbuilder'
  end 

  def create
    provider = Provider.new(
                    name: params[:name],
                    address: params[:address]
    )
    if provider.save
      render json: {message: 'Provider created successfully'}, status: :created
    else 
      render json: {errors: provider.errors.full_messages}, status: :bad_request
    end
  end 

  def show
    @provider = Provider.find(params[:id])
    render 'show.json.jbuilder'
  end 

  def update
    @provider = Provider.find(params[:id])

    @provider.name = params[:name] || provider.name
    @provider.address = params[:address] || provider.address

    if @provider.save
      render 'show.json.jbuilder'
    else
      render json: {errors: providers.errors.full_messages}, status: :unprocessable_entity
    end
  end 

  def destroy
    @provider = Provider.find(params[:id])
    @provider.destroy
    render json: {message: "Successfully destroyed provider ##{provider.id}"}
  end 
end

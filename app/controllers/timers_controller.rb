class TimersController < ApplicationController
  def index
    @timers = Timer.all

    search_term = params[:search]
    if search_term
      @timers = timers.where(" iLIKE ? OR  iLIKE ?", "%#{search_term}%", "%#{search_term}%")
    end
    
    render 'index.json.jbuilder'
  end 

  def create
    user = Timer.new(
                    last_rang: params[:last_rang],
                    increment: params[:increment],
                    timerable_id: params[:timerable_id],
                    timerable_type: params[:timerable_type],               
    )
    if timer.save
      render json: {message: 'Timer created successfully'}, status: :created
    else 
      render json: {errors: timer.errors.full_messages}, status: :bad_request
    end
  end 

  def show
    @timer = Timer.find(params[:id])
    render 'show.json.jbuilder'
  end 

  def update
    @timer = Timer.find(params[:id])
    
    @timer.last_rang = params[:last_rang] || timer.last_rang
    @timer.increment = params[:increment] || timer.increment
    @timer.timerable_id = params[:timerable_id] || timer.timerable_id
    @timer.timerable_type = params[:timerable_type] || timer.timerable_type

    if @timer.save
      render 'show.json.jbuilder'
    else
      render json: {errors: timer.errors.full_messages}, status: :unprocessable_entity
    end
  end 

  def destroy
    timer = Timer.find(params[:id])
    timer.destroy
    render json: {message: "Successfully destroyed timer ##{timer.id}"}
  end 
end

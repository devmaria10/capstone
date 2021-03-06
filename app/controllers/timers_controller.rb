class TimersController < ApplicationController
  def index
    @timers = Timer.all
    
    render 'index.json.jbuilder'
  end 
# route: /users/:id/timers. retrieve user id with params[:user_id]
  def create
    timer = Timer.new(
                    last_rang: Time.now,
                    time_increment: params[:time_increment],
                    increment_unit: params[:increment_unit],
                    timerable_id: params[:timerable_id],
                    timerable_type: params[:timerable_type],
                    repeating: params[:repeating]              
    )

    if timer.save
      user = timer.timerable.user
      text = "your medication"
      ReminderJob.set(wait: eval("#{timer.time_increment}.#{timer.increment_unit}")).perform_later(timer, user.phone_number, text)

      render json: {message: 'Reminder created successfully'}, status: :created
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
    @timer.increment = params[:time_increment] || timer.time_increment
    @timer.increment_unit = params[:increment_unit] || timer.increment_unit
    @timer.timerable_id = params[:timerable_id] || timer.timerable_id
    @timer.timerable_type = params[:timerable_type] || timer.timerable_type
    @timer.repeating = params[:repeating] || timer.repeating

    if @timer.save
      ReminderJob.set(wait: 1.minute).perform_later(timer)
      render 'show.json.jbuilder'
    else
      render json: {errors: timer.errors.full_messages}, status: :unprocessable_entity
    end
  end 

  def destroy
    @timer = Timer.find(params[:id])
    @timer.destroy
    render json: {message: "Successfully destroyed timer ##{timer.id}"}
  end 

end

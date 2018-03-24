class NotesController < ApplicationController
  def index
    @notes = Note.all
    
    render 'index.json.jbuilder'
  end 

  def create
    note = Note.new(
                    date: Time.now,
                    note: params[:note]           
    )

    if note.save
      render json: {message: 'Note created successfully'}, status: :created
    else 
      render json: {errors: note.errors.full_messages}, status: :bad_request
    end
  end 
end

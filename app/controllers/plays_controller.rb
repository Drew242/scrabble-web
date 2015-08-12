class PlaysController < ApplicationController
  def index
    @plays = Play.all
  end

  def new
    @play = Play.new
  end

  def create
    @play = Play.new(play_params)
    if @play.save
      redirect_to plays_path
    else
      flash.now[:errors] = "Word cannot be blank or have special characters"
      render :new
    end
  end

  private

  def play_params
    params.require(:play).permit(:word)
  end
end

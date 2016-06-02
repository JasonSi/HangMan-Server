class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :update]

  # GET /players/1
  # GET /players/1.json
  def show
    render json: @player
  end

  # PATCH/PUT /players/1
  # PATCH/PUT /players/1.json
  def update
    @player = Player.find(params[:id])

    if @player.update(player_params)
      head :no_content
    else
      render json: @player.errors, status: :unprocessable_entity
    end
  end

  def feedback
    prms = params.permit('email','content')
    @feedback = Feedback.new(prms)
    if @feedback.save
      FeedbackMailer.send_feedback(@feedback).deliver_now
      render json: {message: 'Feedback Success!'}
    else
      render json: {message: 'Feedback Failed!'}
    end
  end

  private

    def set_player
      @player = Player.find(params[:id])
    end

    def player_params
      params.require(:player).permit(:nick_name)
    end
end

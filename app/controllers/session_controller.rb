class SessionController < ApplicationController
  def game_start
    # 只允许传递appKey和uid参数
    prms = params.permit('uid','appKey')
    app = AppKey.find_by_key prms['appKey']
    # 如果未授权，找不到对应的key，则不予注册
    return render json: {message: 'No access!'} if app.nil?
    
    t = Player.find_by_uid prms['uid']
    # 如果用户不存在，则新建这个用户
    if t.nil?
      player = Player.new
      player.uid = prms['uid']
      unless player.save
        return render json: {message: 'Wrong uid'}
      end
      t = player
    end

    session[:uid] = t.uid
    session[:player_id] = t.id
    session[:game_id] = Digest::SHA2.hexdigest(rand(141217).to_s)
    render json: game_is_on(session[:game_id])
  end

  private
    def game_is_on(game_id)
      {
        message: "THE GAME IS ON",
        gameId: game_id,
        data: {
           numberOfWordsToGuess: 20,
           numberOfGuessAllowedForEachWord: 10
        }
      }
    end
end

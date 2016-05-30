class SessionController < ApplicationController
  def start_game
    # 只允许传递appKey和uid参数
    prms = params.permit('uid','appKey')
    app = AppKey.find_by_key prms['appKey']
    # 如果未授权，找不到对应的key，则不予注册
    return render json: {message: 'No Access!'} if app.nil?

    player = Player.find_by_uid prms['uid']
    # 如果用户不存在，则新建这个用户
    if player.nil?
      new_player = Player.new(uid: prms['uid'])
      unless new_player.save
        return render json: {message: 'Wrong UID'}
      end
      player = new_player
    end
    # 此处应该关闭上个回话，初始化游戏
    reset_session
    session[:uid] = player.uid
    session[:player_id] = player.id
    @@game = Game.new(session[:session_id], player.uid)
    render json: @@game.start_game
  end

  def next_word
    prms = params.permit('sessionId')
    session_access(prms['sessionId'], @@game.next_word)
  end

  def guess_word
    prms = params.permit('sessionId', 'guess')
    session_access(prms['sessionId'], @@game.guess_word(prms['guess']))
  end

  def get_result
    prms = params.permit('sessionId')
    session_access(prms['sessionId'], @@game.get_result)
  end

  def submit_result
    prms = params.permit('sessionId')
    session_access(prms['sessionId'], @@game.submit_result)
  end

  private
    def session_access sid,res
      if sid == session[:session_id]
        render json: res
      else
        render json: {message: 'Wrong Request!'}
      end
    end
end

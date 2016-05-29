class SessionController < ApplicationController
  def start_game
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

  def next_word
    prms = params.permit('gameId')
    byebug
    if prms['gameId'] == session[:game_id]
      render json: give_me_a_word
    else
      render json: {message: 'Wrong request!'}
    end
  end

  def guess_word
    prms = params.permit('gameId', 'guess')
    if prms['gameId'] == session[:game_id]
      render json: make_a_guess(prms['guess'])
    else
      render json: {message: 'Wrong request!'}
    end
  end

  def get_result
    prms = params.permit('gameId')
    if prms['gameId'] == session[:game_id]
      render json: get_your_result
    else
      render json: {message: 'Wrong request!'}
    end
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

    def give_me_a_word
      {
        gameId: session[:game_id],
        data: {
          word: "*****",
          totalWordCount: 1,
          wrongGuessCountOfCurrentWord: 0
        }
      }
    end

    def make_a_guess(guess)
      {
        gameId: session[:game_id],
        data: {
          word: "**#{guess}**",
          totalWordCount: 1,
          wrongGuessCountOfCurrentWord: 2
        }
      }
    end

    def get_your_result
      {
        gameId: session[:game_id],
        data: {
          totalWordCount: 20,
          correctWordCount: 18,
          totalWrongGuessCount: 80,
          score: 280
        }
      }
    end
end

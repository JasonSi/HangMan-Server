class SessionController < ApplicationController
  before_action :wtf, except: [:start_game]
  before_action :session_access, except: [:start_game, :quit_game]

  include GameHelper
  def start_game
    # 只允许传递appKey和uid参数
    prms = params.permit('uid','appKey')
    return render json: {message: 'Wrong Parameters!'} if prms['uid'].nil? || prms['appKey'].nil?
    # 如果未授权，找不到对应的key，则不予注册
    app = AppKey.find_by_key prms['appKey']
    return render json: {message: 'No Access!'} if app.nil?
    # 用户UID不符合规范等导致注册失败
    return render json: {message: 'Wrong UID'} unless set_player(prms)
    # 此处应该关闭上个回话，初始化游戏
    reset_session
    session[:uid] = @player.uid
    session[:player_id] = @player.id
    session[:game_data] = game_is_on(@player.uid, @player.id)
    render json: res_game_is_on(session[:game_data])
  end

  def next_word
    if session[:game_data][:number_of_words_to_guess] == session[:game_data][:total_word_count]
      render json: {message: "No Words Left!"}
    else
      session[:game_data] = give_me_a_word(session[:game_data])
      render json: res_give_me_a_word(session[:game_data])
    end
  end

  def guess_word
    prms = params.permit('guess')
    return render json: {message: 'Wrong Parameters!'} if prms['guess'].nil?
    session[:game_data] = make_a_guess(session[:game_data], prms['guess'].upcase)
    render json: res_make_a_guess(session[:game_data], prms['guess'].upcase)
  end

  def submit_result
    if submit_your_result(session[:game_data])
      render json: res_submit_your_result(session[:game_data])
    else
      render json: {message: 'Score Saving Failed!'}
    end
  end

  def quit_game
    session[:uid] = nil
    render json: res_quit_this_game(session[:game_data])
  end

  private
    def session_access
      return render json: {message: 'No Session!'} if session[:uid].nil?
    end


    def wtf
      # session[:game_data]里的Key有时是Symbol有时是String,处理一下，都规范成Symbol
      session[:game_data] = session[:game_data].inject({}){|h,(k,v)| h[k.to_sym] = v; h}
    end

    def set_player(prms)
      # UID全部采用大写储存，如果查找小写的，就全部转换成大写再查找
      @player = Player.find_by_uid prms['uid'].upcase
      # 如果用户不存在，则新建这个用户
      if @player.nil?
        new_player = Player.new(uid: prms['uid'].upcase)
        unless new_player.save
          return false
        end
        @player = new_player
      end
      true
    end

end

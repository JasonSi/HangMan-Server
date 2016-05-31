class SessionController < ApplicationController
  before_action :wtf
  before_action :session_access, except: [:start_game, :quit_game]

  include GameHelper
  def start_game
    # 只允许传递appKey和uid参数
    prms = params.permit('uid','appKey')
    # 如果未授权，找不到对应的key，则不予注册
    app = AppKey.find_by_key prms['appKey']
    return render json: {message: 'No Access!'} if app.nil?
    # 用户UID不符合规范等导致注册失败
    return render json: {message: 'Wrong UID'} unless set_player(prms)
    # 此处应该关闭上个回话，初始化游戏
    reset_session
    session[:uid] = @player.uid
    session[:player_id] = @player.id
    session[:game_data] = game_is_on(@player.uid)
    render json: res_game_is_on(session[:game_data])
  end

  def next_word
    session[:game_data] = give_me_a_word(session[:game_data])
    render json: res_give_me_a_word(session[:game_data])
  end

  def guess_word
    prms = params.permit('guess')
    session[:game_data] = make_a_guess(session[:game_data])
    render json: res_make_a_guess(session[:game_data])
  end

  def get_result
    session[:game_data] = get_your_result(session[:game_data])
    render json: res_get_your_result(session[:game_data])
  end

  def submit_result
    session[:game_data] = submit_your_result(session[:game_data])
    render json: res_submit_your_result(session[:game_data])
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
      # session[:game_data]里的KEY有时是Symbol有时是String,处理一下，都规范成Symbol
      session[:game_data] = session[:game_data].inject({}){|h,(k,v)| h[k.to_sym] = v; h}
    end

    def set_player(prms)
      @player = Player.find_by_uid prms['uid']
      # 如果用户不存在，则新建这个用户
      if @player.nil?
        new_player = Player.new(uid: prms['uid'])
        unless new_player.save
          return false
        end
        @player = new_player
      end
      true
    end

end

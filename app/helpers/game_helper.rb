module GameHelper
  SCORE_OF_RIGHT_WORD = 20
  def get_score data
    data[:correct_word_count] * SCORE_OF_RIGHT_WORD - data[:total_wrong_guess_count]
  end

  # 游戏逻辑
  def game_is_on(uid, pid, num_to_guess = 20, num_allowed = 10)
    wordlist = Vocabulary.get_random_words(num_to_guess)
    {
      number_of_words_to_guess: num_to_guess,
      number_of_guess_allowed_for_each_word: num_allowed,
      total_word_count: 0,
      correct_word_count: 0,
      wrong_guess_count_of_current_word: 0,
      total_wrong_guess_count: 0,
      score: 0,
      uid: uid,
      player_id: pid,
      wordlist: wordlist,
      original_word: wordlist.first,
      current_word: wordlist.first.gsub(/[A-Z]/, '*')
    }
  end

  def give_me_a_word data
    data[:original_word] = data[:wordlist][data[:total_word_count]]
    data[:current_word] = data[:original_word].gsub(/[A-Z]/, '*')
    data[:total_word_count] += 1
    data[:wrong_guess_count_of_current_word] = 0
    data
  end

  def make_a_guess data, guess
    if data[:wrong_guess_count_of_current_word] == data[:number_of_guess_allowed_for_each_word]
      # 如果猜错直接返回原数据
      return data
    end

    if data[:current_word].include?(guess)
      # 如果这个字母是已经猜过并正确的直接算猜错，正常情况下不会出现这种
      flag = false
    elsif data[:original_word].include?(guess)
      # 此外，如果单词中包含这个字母，则正确
      flag = true
    else
      # 否则都是错错错
      flag = false
    end

    if flag
      # 猜对字母
      # 获得该字母在单词中的位置，数组形式
      pos = data[:original_word].split("").map.with_index{|w,i| i if w==guess}.compact
      # 替换掉星号
      pos.each{|i| data[:current_word][i] = guess }
      data[:correct_word_count] += 1 if data[:current_word] == data[:original_word]
    else
      # 猜错字母
      data[:wrong_guess_count_of_current_word] += 1
      data[:total_wrong_guess_count] += 1
    end
    data[:score] = get_score(data)
    data
  end

  # def get_your_result data
  # end

  def submit_your_result data
    player = Player.find_by_id(data[:player_id])
    return false if player.nil?
    scr = Score.new
    scr.player_id = player.id
    scr.total_word = data[:total_word_count]
    scr.correct_word = data[:correct_word_count]
    scr.wrong_guess = data[:total_wrong_guess_count]
    scr.grade = data[:score]
    scr.save ? true : false
  end

  # 响应数据结构
  def res_common_data data
    {
      "真实单词用以测试": data[:original_word],
      totalWordCount: data[:total_word_count],
      correctWordCount: data[:correct_word_count],
      totalWrongGuessCount: data[:total_wrong_guess_count],
      score: data[:score]
    }
  end

  def res_game_is_on data
    {
      message: "The Game Is On",
      numberOfWordsToGuess: data[:number_of_words_to_guess],
      numberOfGuessAllowedForEachWord: data[:number_of_guess_allowed_for_each_word]
    }
  end

  def res_give_me_a_word data
    {
      message: "This Is A New Word",
      word: data[:current_word],
      wrongGuessCountOfCurrentWord: data[:wrong_guess_count_of_current_word]
    }.merge(res_common_data(data))
  end

  def res_make_a_guess(data, guess)
    {
      message: "Your Guess Is " + guess,
      word: data[:current_word],
      wrongGuessCountOfCurrentWord: data[:wrong_guess_count_of_current_word]
    }.merge(res_common_data(data))
  end

  def res_submit_your_result data
    {
      message: "Game Over",
      uid: data[:uid]
    }.merge(res_common_data(data))
  end

  def res_quit_this_game data
    {
      message: "Exited"
    }
  end


end

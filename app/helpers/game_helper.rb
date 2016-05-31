module GameHelper
  def get_score data
    data[:correct_word_count] * 20 - data[:total_wrong_guess_count]
  end

  # 游戏逻辑
  def game_is_on(uid, num_to_guess = 20, num_allowed = 10)
    wordlist = Vocabulary.get_random_words(num_to_guess)
    {
      number_of_words_to_guess: num_to_guess,
      number_of_guess_allowed_for_each_word: num_allowed,
      total_word_count: 1,
      correct_word_count: 0,
      wrong_guess_count_of_current_word: 0,
      total_wrong_guess_count: 0,
      score: 0,
      uid: uid,
      wordlist: wordlist,
      original_word: wordlist.first,
      current_word: "****************************".slice(0, wordlist.first.length)
    }
  end

  def give_me_a_word data
  end

  def make_a_guess data
  end

  def get_your_result data
  end

  def submit_your_result data
  end

  # 响应数据结构
  def res_game_is_on data
    {
      message: "THE GAME IS ON",
      numberOfWordsToGuess: data[:number_of_words_to_guess],
      numberOfGuessAllowedForEachWord: data[:number_of_guess_allowed_for_each_word]
    }
  end

  def res_give_me_a_word data
    {
      message: "THIS IS A NEW WORD",
      word: data[:current_word],
      totalWordCount: data[:total_word_count],
      wrongGuessCountOfCurrentWord: data[:wrong_guess_count_of_current_word]
    }
  end

  def res_make_a_guess(data, guess)
    {
      message: "CURRENT WORD IS HERE",
      word: data[:current_word],
      totalWordCount: data[:total_word_count],
      wrongGuessCountOfCurrentWord: data[:wrong_guess_count_of_current_word]
    }
  end

  def res_get_your_result data
    {
      message: "THIS IS YOUR RESULT",
      totalWordCount: data[:total_word_count],
      correctWordCount: data[:correct_word_count],
      totalWrongGuessCount: data['total_wrong_guess_count'],
      score: data[:score]
    }
  end

  def res_submit_your_result data
    {
      message: "GAME OVER",
      uid: data[:uid],
      totalWordCount: data[:total_word_count],
      correctWordCount: data[:correct_word_count],
      totalWrongGuessCount: data['total_wrong_guess_count'],
      score: data[:score],
      datetime: Time.new
    }
  end

  def res_quit_this_game data
    {
      message: "EXIT"
    }
  end


end

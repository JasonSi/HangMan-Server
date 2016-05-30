class Game
  def initialize(session_id, uid, num_to_guess = 20, num_allowed = 10)
    @number_of_words_to_guess = num_to_guess
    @number_of_guess_allowed_for_each_word = num_allowed
    @total_word_count = 1
    @correct_word_count = 0
    @wrong_guess_count_of_current_word = 0
    @total_wrong_guess_count = 0
    @score = 0

    @uid = uid
    @session_id = session_id
    @wordlist = Vocabulary.get_random_words(num_to_guess)
    @original_word = @wordlist.first
    @current_word = "*********************************".slice(0, @original_word.length)
  end

  def start_game
    game_is_on
  end

  def next_word
    give_me_a_word
  end

  def guess_word(letter)
    @current_word[3] = letter
    make_a_guess(letter)
  end

  def get_result
    get_your_result
  end

  def submit_result
    @score = get_score
    # 返回的数据在session里 顺便要存数据库
    submit_your_result
  end

  private
    def get_score
      @correct_word_count * 20 - @total_wrong_guess_count
    end

    def game_is_on
      {
        message: "THE GAME IS ON",
        sessionId: @session_id,
        data: {
          numberOfWordsToGuess: @number_of_words_to_guess,
          numberOfGuessAllowedForEachWord: @number_of_guess_allowed_for_each_word
        }
      }
    end

    def give_me_a_word
      {
        sessionId: @session_id,
        data: {
          word: @current_word,
          totalWordCount: @total_word_count,
          wrongGuessCountOfCurrentWord: @wrong_guess_count_of_current_word
        }
      }
    end

    def make_a_guess(guess)
      {
        sessionId: @session_id,
        data: {
          word: @current_word,
          totalWordCount: @total_word_count,
          wrongGuessCountOfCurrentWord: @wrong_guess_count_of_current_word
        }
      }
    end

    def get_your_result
      {
        sessionId: @session_id,
        data: {
          totalWordCount: @total_word_count,
          correctWordCount: @correct_word_count,
          totalWrongGuessCount: @total_wrong_guess_count,
          score: @score
        }
      }
    end

    def submit_your_result
      {
        message: "GAME OVER",
        sessionId: @session_id,
        data: {
          uid: @uid,
          totalWordCount: @total_word_count,
          correctWordCount: @correct_word_count,
          totalWrongGuessCount: @total_wrong_guess_count,
          score: @score,
          datetime: Time.new
        }
      }
    end

end

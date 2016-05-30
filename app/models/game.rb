class Game
  def initialize(session_id, num_to_guess = 20, num_allowed = 10)
    @number_of_words_to_guess = num_to_guess
    @number_of_guess_allowed_for_each_word = num_allowed
    @total_word_count = 1
    @correct_word_count = 0
    @wrong_guess_count_of_current_word = 0
    @total_wrong_guess_count = 0
    @score = 0

    @session_id = session_id
    @wordlist = Vocabulary.get_random_words(num_to_guess)
    @current_word = @wordlist.first
  end



  private
    def get_score
      @correct_word_count * 20 - @total_wrong_guess_count
    end

end

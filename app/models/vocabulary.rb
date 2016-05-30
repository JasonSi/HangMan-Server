class Vocabulary < ActiveRecord::Base
  def self.get_random_words(num = 20)
    # 此处以后修改，相同长度的单词数量应该有所限制
    Vocabulary.order("RAND()").limit(num).pluck(:word)
  end
end

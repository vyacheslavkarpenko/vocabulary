class Translate
  include Mongoid::Document
  field :word, type: String
  field :transcription, type: String
  field :translate, type: String
  field :learned, type: Mongoid::Boolean
  field :repeited, type: Integer

  validates :word, uniqueness: true
  validates :word, :translate, presence: true
  before_save :word_downcase
  before_save :translate_downcase

  def learn(arg)
    update(learned: arg)
  end

  def repeit(arg)
    update(repeited: arg)
  end

  def word_downcase
    self.word = word.downcase
  end

  def translate_downcase
    self.translate = translate.downcase
  end
end

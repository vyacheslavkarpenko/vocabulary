class Translate
  include Mongoid::Document
  field :word, type: String
  field :translate, type: String
  field :learned, type: Mongoid::Boolean
  field :repeited, type: Integer

  validates :word, uniqueness: true
  validates :word, :translate, presence: true

  def learn(arg)
    update(learned: arg)
  end

  def repeit(arg)
    update(repeited: arg)
  end
end

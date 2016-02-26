class Entry < ActiveRecord::Base
  validates :word, presence: true, length: {maximum: 50}

  has_many :definitions, dependent: :destroy
end

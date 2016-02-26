class Definition < ActiveRecord::Base
  belongs_to :entry

  validates :description, presence: true
end

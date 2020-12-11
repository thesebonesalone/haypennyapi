class Opinion < ApplicationRecord
    has_many :reactions
    belongs_to :user
    belongs_to :topic
    validates :content, length: { minimum: 10, maximum: 256}
end

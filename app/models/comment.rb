class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :opinion
    has_many :votes, dependent: :destroy
end

class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :opinion
    has_many :comment_votes
end

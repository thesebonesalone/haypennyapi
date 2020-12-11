class Topic < ApplicationRecord
    has_many :opinions
    validates :title, uniqueness: true
end

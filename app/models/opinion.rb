class Opinion < ApplicationRecord
    has_many :reactions
    belongs_to :user
    belongs_to :topic
    has_many :children, class_name: "Opinion", :foreign_key => "parent_id"
    belongs_to :parent, :class_name => "Opinion"
end

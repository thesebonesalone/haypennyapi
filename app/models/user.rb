class User < ApplicationRecord
    has_secure_password
    has_many :comments
    has_many :votes
    has_many :opinions
    has_many :reactions
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i     
    validates :email, presence: true, uniqueness: {case_sensitive: false},
                length: {maximum: 105},
                format: { with: VALID_EMAIL_REGEX}
    validates :name, uniqueness: true
    # validates :email,
    # format: { with: /^(.+)@(.+)$/, message: "Email invalid"  },
    #         uniqueness: { case_sensitive: false },
    #         length: { minimum: 4, maximum: 254 }
end

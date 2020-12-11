class User < ApplicationRecord
    has_secure_password
    has_many :opinions
    has_many :reactions
    validates :email, uniqueness: true
    validates :name, uniqueness: true
    # validates :email,
    # format: { with: /^(.+)@(.+)$/, message: "Email invalid"  },
    #         uniqueness: { case_sensitive: false },
    #         length: { minimum: 4, maximum: 254 }
end

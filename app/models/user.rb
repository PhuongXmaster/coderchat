class User < ActiveRecord::Base
    has_many :sent_messages, class_name: "Message", foreign_key: "sender_id"
    has_many :received_messages, class_name: "Message", foreign_key: "receiver_id"
    has_many :friends, class_name: "Connection", foreign_key: "from_id"

    has_secure_password

    validates :email, :name, :password, :password_confirmation, presence: true
    validates_confirmation_of :password
end

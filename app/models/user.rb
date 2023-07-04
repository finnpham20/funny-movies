# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string(256)      not null
#  password_digest :string(256)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: true, format: { with: RegexConstant::EMAIL_FORMAT }
  validates :password, length: { in: 8..40 },
            format: { with: RegexConstant::PASSWORD_FORMAT,
                      message: 'Your password must be at least 8 characters long, contain at least one number and @ and have a mixture of uppercase and lowercase letters.' },
            confirmation: true, on: :create

  has_many :posts, dependent: :destroy
end

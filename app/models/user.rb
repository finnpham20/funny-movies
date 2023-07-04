# frozen_string_literal: true

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

  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: RegexConstant::EMAIL_FORMAT }
  validates :password, presence: true,
                       length: { in: 8..40 },
                       format: { with: RegexConstant::PASSWORD_FORMAT,
                                 message: I18n.t('errors.models.user.password_format') },
                       confirmation: true, on: :create

  has_many :posts, dependent: :destroy
end

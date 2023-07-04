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
require 'rails_helper'

RSpec.describe User do
  let(:user) { create(:user) }

  describe 'Associations' do
    it { is_expected.to have_many(:posts).dependent(:destroy) }
  end

  describe 'validations' do
    it 'valid user' do
      expect(user).to be_valid
    end

    describe 'validate presence' do
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_presence_of(:password) }
    end

    describe 'validate uniqueness' do
      subject { build(:user) }

      it { is_expected.to validate_uniqueness_of(:email) }
    end

    describe 'validate password format' do
      let(:user_too_short) { create(:user, password: '123') }
      let(:user_too_long) { create(:user, password: 'Ab@12' * 10) }
      let(:user_wrong_format) { create(:user, password: 'abc12345678') }

      it 'raise error when password too short' do
        expect { user_too_short }.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'raise error when password too long' do
        expect { user_too_long }.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'raise error when password wrong format' do
        expect { user_wrong_format }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    describe 'validate email format' do
      let(:user_wrong_format) { create(:user, email: 'finnpham20gmail.com') }

      it 'raise error when email wrong format' do
        expect { user_wrong_format }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end

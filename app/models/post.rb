# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id          :bigint           not null, primary key
#  user_id     :bigint           not null
#  youtube_url :string(500)      not null
#  video_id    :string(256)
#  title       :string(1000)
#  status      :integer          default("pending")
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Post < ApplicationRecord
  belongs_to :user

  enum status: { pending: 0, shared: 1, unshared: 2 }

  validates :youtube_url, presence: true, format: { with: RegexConstant::YOUTUBE_URL_FORMAT,
                                                    message: I18n.t('errors.models.post.youtube_url_format') }
  validates :video_id, presence: true,
                       uniqueness: { scope: :user_id, message: I18n.t('errors.models.post.video_id_taken') }

  before_validation :extract_video_id, on: :create

  private

  def extract_video_id
    param_list = youtube_url.split('?')[1].split('&')
    vid = param_list.find { |k| k.include?('v=') }
    self.video_id = vid.gsub('v=', '')
  rescue StandardError
    self.video_id = nil
  end
end

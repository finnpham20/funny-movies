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
FactoryBot.define do
  factory :post do
    user

    youtube_url { 'https://www.youtube.com/watch?v=t0Q2otsqC4I' }
  end
end

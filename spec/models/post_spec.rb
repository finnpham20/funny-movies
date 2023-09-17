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
require 'rails_helper'

RSpec.describe Post do
  let(:post) { create(:post) }

  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it 'valid post' do
      expect(post).to be_valid
    end

    describe 'validate presence' do
      it { is_expected.to validate_presence_of(:youtube_url) }
      it { is_expected.to validate_presence_of(:video_id) }
    end

    describe 'validate youtube url format' do
      let(:post_new) { create(:post, youtube_url: 'https://yout.com/watch?v=123') }

      it 'raise error when youtube url wrong format' do
        expect { post_new }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe '#extract_video_id' do
    context 'when extract default video id' do
      it { expect(post.video_id).to eq 't0Q2otsqC4I' }
    end

    context 'when youtube_url multi params' do
      let(:post_new_2) do
        create(:post, youtube_url: 'https://www.youtube.com/watch?v=mb_J9bPVLfQ&list=RDCMUCovuxCOoG5G6CfjMoxG9adw&start_radio=1')
      end

      it { expect(post_new_2.video_id).to eq 'mb_J9bPVLfQ' }
    end

    context 'when youtube_url is invalid' do
      let(:post_new_3) do
        build(:post, youtube_url: 'https://www.youtube.com/watch/invalid')
      end

      it { expect(post_new_3.video_id).to be_nil }
    end
  end
end

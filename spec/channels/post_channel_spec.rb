require 'rails_helper'

RSpec.describe PostChannel do
  let(:user) { create(:user) }

  it 'successfully identifies the current user' do
    stub_connection current_user: user
    subscribe
    expect(connection.current_user).to eq(user)
  end

  it 'does not identify a current user if not provided' do
    stub_connection current_user: nil
    subscribe
    expect(connection.current_user).to be_nil
  end

  it 'subscribes to the stream' do
    stub_connection current_user: user
    subscribe
    expect(subscription).to be_confirmed
    expect(subscription).to have_stream_for('post:post_channel')
  end

  it 'broadcasts a message when an event occurs' do
    stub_connection current_user: user
    subscribe
    msg = { video_id: '123', title: 'title123', description: 'test', email: 'finn@gmail.com' }
    expect do
      ActionCable.server.broadcast('post_channel', msg)
    end.to have_broadcasted_to('post_channel').with(msg)
  end
end

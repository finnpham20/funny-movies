require 'rails_helper'

RSpec.describe ApplicationCable::Connection do
  let(:user) { create(:user) }

  it 'successfully connects' do
    stub_connection current_user: user
    allow(cookies).to receive_message_chain(:signed, :[]).with(:user_id).and_return(user.id)

    connect '/cable'
    expect(connection.current_user.id).to eq user.id
  end

  it 'rejects connection' do
    allow(cookies).to receive_message_chain(:signed, :[]).with(:user_id).and_return(nil)

    expect { connect '/cable' }.to have_rejected_connection
  end
end

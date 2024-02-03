# frozen_string_literal: true

RSpec.describe Api::V1::RegistrationsController, type: :controller do
  describe 'POST #create' do
    let(:user_params) { { email: 'test@example.com', password: 'password' } }

    context 'when user is valid' do
      it 'creates a new user' do
        expect { post :create, params: { user: user_params } }.to change(User, :count).by(1)
      end

      it 'returns a 201 status code' do
        post :create, params: { user: user_params }
        expect(response).to have_http_status(:created)
      end
    end

    context 'when user is invalid' do
      let(:user_params) { { email: '', password: '' } }

      it 'does not create a new user' do
        expect { post :create, params: { user: user_params } }.not_to change(User, :count)
      end

      it 'returns a 422 status code' do
        post :create, params: { user: user_params }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns an error message' do
        post :create, params: { user: user_params }
        expect(JSON.parse(response.body)['error']).to eq('Can not create user this time')
      end
    end
  end
end
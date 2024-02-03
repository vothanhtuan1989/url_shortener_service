# frozen_string_literal: true

RSpec.describe Api::V1::SessionsController, type: :controller do
  describe 'GET #show' do
    let(:user) { create(:user) }

    context 'when user is authenticated' do
      before do
        sign_in user
        request.headers['Content-Type'] = 'application/json'
        request.headers['X-User-Email'] = user.email
        request.headers['X-User-Token'] = user.authentication_token
        get :show
      end

      it 'returns a 200 status code' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when user is not authenticated' do
      before do
        get :show
      end

      it 'returns a 401 status code' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'POST #create' do
    let(:user) { create(:user) }

    context 'when user credentials are valid' do
      before do
        post :create, params: { email: user.email, password: user.password }
      end

      xit 'returns a 201 status code' do
        expect(response).to have_http_status(:created)
      end

      xit 'returns the user as JSON' do
        expect(JSON.parse(response.body)).to include('id' => user.id, 'email' => user.email, 'authentication_token' => user.authentication_token)
      end
    end

    context 'when user credentials are invalid' do
      before do
        post :create, params: { email: user.email, password: 'wrong' }
      end

      xit 'returns a 401 status code' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { create(:user) }

    context 'when user is authenticated' do
      before do
        sign_in user
        request.headers['Content-Type'] = 'application/json'
        request.headers['X-User-Email'] = user.email
        request.headers['X-User-Token'] = user.authentication_token
        delete :destroy
      end

      it 'returns a 200 status code' do
        expect(response).to have_http_status(:ok)
      end

      xit 'clears the user authentication token' do
        expect(user.reload.authentication_token).to be_nil
      end
    end

    context 'when user is not authenticated' do
      before do
        delete :destroy
      end

      it 'returns a 401 status code' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
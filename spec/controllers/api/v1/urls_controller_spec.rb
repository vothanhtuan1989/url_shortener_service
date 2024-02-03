# frozen_string_literal: true

RSpec.describe Api::V1::UrlsController, type: :controller do
  describe 'POST #shorten' do
    let(:user) { create(:user) }
    let(:original_url) { 'https://www.example.com/long/url' }
    
    context 'when request content type is application/json' do
      before do
        sign_in user
        request.headers['Content-Type'] = 'application/json'
        request.headers['X-User-Email'] = user.email
        request.headers['X-User-Token'] = user.authentication_token
      end
    
      context 'when original url is valid' do
        before do
          post :shorten, params: { original: original_url }
        end
    
        it 'returns a 201 status code' do
          expect(response).to have_http_status(:created)
        end
    
        it 'returns the shortened url as JSON' do
          json = JSON.parse(response.body)
          expect(json).to include('short')
          expect(json['short']).to eq("#{ENV['BASE_URL']}/#{Url.last.short}")
        end
      end
    
      context 'when original url is invalid' do
        before do
          allow(ShortenUrlCommand).to receive(:call).and_return(double(success?: false, errors: { error: 'Invalid url' }))
          post :shorten, params: { original: original_url }
        end
    
        it 'returns a 400 status code' do
          expect(response).to have_http_status(:bad_request)
        end
    
        it 'returns an error message as JSON' do
          json = JSON.parse(response.body)
          expect(json).to include('error')
          expect(json['error']).to eq('Invalid url')
        end
      end
    end
  
    context 'when request content type is not application/json' do
      before do
        sign_in user
        request.headers['Content-Type'] = 'text/plain'
        request.headers['X-User-Email'] = user.email
        request.headers['X-User-Token'] = user.authentication_token
        post :shorten, params: { original: original_url }
      end
    
      it 'returns a 415 status code' do
        expect(response).to have_http_status(:unsupported_media_type)
      end
    
      it 'returns an error message as JSON' do
        json = JSON.parse(response.body)
        expect(json).to include('error')
        expect(json['error']).to eq('Unsupported content type')
      end
    end
  end
end
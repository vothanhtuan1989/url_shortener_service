# frozen_string_literal: true

RSpec.describe ShortenUrlCommand do
  let(:user) { create(:user) }
  let(:command) { described_class.new(current_user: user, original: original) }

  describe '#call' do
    context 'when the original url is valid' do
      let(:original) { 'https://www.example.com' }

      it 'returns a url object with the original and short attributes' do
        result = command.call.result
        expect(result).to be_a(Url)
        expect(result.original).to eq(original)
        expect(result.short).to be_present
      end

      it 'creates a url record in the database' do
        expect { command.call }.to change { Url.count }.by(1)
      end

      it 'associates the url with the current user' do
        result = command.call.result
        expect(result.user).to eq(user)
      end
    end

    context 'when the original url is invalid' do
      let(:original) { 'invalid url' }

      it 'returns false' do
        result = command.call.result
        expect(result).to be(false)
      end

      it 'does not create a url record in the database' do
        expect { command.call }.not_to change { Url.count }
      end

      it 'adds an error to the command object' do
        command.call
        expect(command.errors).to include(:error)
      end
    end
  end
end

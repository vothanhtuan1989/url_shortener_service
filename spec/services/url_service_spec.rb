RSpec.describe UrlService do
  # Define a shared example group for testing the module methods
  shared_examples 'a url service' do
    describe '#valid_url?' do
      context 'when the url is valid' do
        let(:url) { 'https://www.example.com' }

        it 'returns true' do
          expect(subject.valid_url?(url)).to be(true)
        end
      end

      context 'when the url is invalid' do
        let(:url) { 'invalid url' }

        it 'returns false' do
          expect(subject.valid_url?(url)).to be(false)
        end
      end
    end

    describe '#encode_url' do
      let(:url) { 'https://www.example.com' }

      it 'returns a six-character string' do
        expect(subject.encode_url(url)).to be_a(String)
        expect(subject.encode_url(url).length).to eq(6)
      end

      it 'returns the same string for the same url' do
        expect(subject.encode_url(url)).to eq(subject.encode_url(url))
      end

      it 'returns a different string for a different url' do
        other_url = 'https://www.another.com'
        expect(subject.encode_url(url)).not_to eq(subject.encode_url(other_url))
      end
    end
  end

  # Use a dummy class to include the module
  let(:dummy_class) { Class.new { include UrlService } }

  # Use a subject block to define the object under test
  subject { dummy_class.new }

  # Include the shared example group
  it_behaves_like 'a url service'
end
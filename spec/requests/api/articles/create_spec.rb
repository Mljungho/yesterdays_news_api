RSpec.describe 'POST /api/articles', type: :request do
  subject { response }
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }

  describe 'with valid params' do
    describe 'as anonumos user' do
      before do
        post '/api/articles', params: {
          article: {
            title: 'Mars and Venus together',
            body: 'There is water on Mars',
            category: 'news'
          }
        }, headers: nil
        @article = Article.last
      end

      it { is_expected.to have_http_status :unauthorized }
    end

    describe 'as an authenticated user' do
      before do
        post '/api/articles', params: {
          article: {
            title: 'Mars and Venus together',
            body: 'There is water on Mars',
            category: 'news'
          }
        }, headers: credentials
        @article = Article.last
      end

      it { is_expected.to have_http_status :created }

      it 'is expected to create an instance of Article' do
        expect(@article).to_not eq nil
      end

      it 'is expected to have saved the article in the database' do
        expect(@article.title).to eq 'Mars and Venus together'
      end

      it 'is expected to respond with a confirmation message' do
        expect(response_json['message']).to eq 'Article created successfully'
      end
    end
  end

  describe 'unsuccessfully' do
    describe 'due to missing params' do
      before do
        post '/api/articles', params: {}, headers: credentials
      end

      it { is_expected.to have_http_status :unprocessable_entity }

      it 'is expected to respond with an error message' do
        expect(response_json['message']).to eq 'Missing params'
      end
    end

    describe 'due to missing title' do
      before do
        post '/api/articles', params: {
          article: {
            body: 'There is water on Mars',
            category: 'news'
          }
        }, headers: credentials
      end

      it { is_expected.to have_http_status :unprocessable_entity }

      it 'is expected to respond with an error message' do
        expect(response_json['message']).to eq "Title can't be blank"
      end
    end

    describe 'due to missing body' do
      before do
        post '/api/articles', params: {
          article: {
            title: 'Mars and Venus together',
            category: 'news'
          }
        }, headers: credentials
      end

      it { is_expected.to have_http_status :unprocessable_entity }

      it 'is expected to respond with an error message' do
        expect(response_json['message']).to eq "Body can't be blank"
      end
    end

    describe 'due to missing category' do
      before do
        post '/api/articles', params: {
          article: {
            title: 'Mars and Venus together',
            body: 'There is water on Mars'
          }
        }, headers: credentials
      end

      it { is_expected.to have_http_status :unprocessable_entity }

      it 'is expected to respond with an error message' do
        expect(response_json['message']).to eq "Category can't be blank"
      end
    end
  end
end
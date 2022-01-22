RSpec.describe 'GET /api/admin/articles', type: :request do
  subject { response }
  let!(:user) { create(:user, id: 1) }
  let!(:article) { 30.times { create(:article) } }

  describe 'successfully' do
    describe 'without params' do
      before do
        get '/api/admin/articles'
      end

      it { is_expected.to have_http_status :ok }

      it 'is expected to return 20 articles' do
        expect(response_json['articles'].count).to eq 20
      end

      it 'is expected to respond with an article with title "Covid-19 is a pandemic"' do
        expect(response_json['articles'].first['title']).to eq 'Covid-19 is a pandemic'
      end
    end

    describe 'with a category param' do
      before do
        get '/api/admin/articles', params: { email: 'journalist@test.com' }
      end

      it { is_expected.to have_http_status :ok }

      it 'is expected to respond with a collection of 20 articles' do
        expect(response_json['articles'].count).to eq 20
      end

      it 'is expected to respond with a collection of articles with "Politics" category' do
        expect(response_json['articles'].all? { |article| article['category'] == 'Politics' })
          .to eq true
      end
    end
  end
end

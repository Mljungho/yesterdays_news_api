RSpec.describe 'GET /api/articles', type: :request do
  subject { response }
  let!(:article) { 30.times { create(:article) } }

  describe 'successfully' do
    describe 'without params' do
      before do
        get '/api/articles'
      end

      it { is_expected.to have_http_status :ok }

      it 'is expected to return 20 articles' do
        expect(response_json['articles'].count).to eq 20
      end

      # it 'is expected to respond with an article with title "Covid-19 is a pandemic"' do
      #   expect(response_json['articles'].first['title']).to eq 'Covid-19 is a pandemic'
      # end
    end

    describe 'with a category param' do
      before do
        get '/api/articles', params: { category: 'politics' }
      end

      it { is_expected.to have_http_status :ok }

      it 'is expected to respond with a collection of 20 articles' do
        expect(response_json['articles'].count).to eq 20
      end

      it 'is expected to respond with a collection of articles with "politics" category' do
        expect(response_json['articles'].all? { |article| article['category'] == 'politics' })
          .to eq true
      end
    end
  end
end

require "rails_helper"

RSpec.describe 'ApiMoviesController', type: :request do
  context 'when passing valid data' do
    describe 'POST #import' do
      it 'must return 201' do

        user = create(:user)
        api_movies_params = {title: 'Batman'}

        post '/import_movies', params: {movie: api_movies_params}, headers: get_headers(user)

        expect(response).to have_http_status(:created) 
        
      end
    end 

    it 'need to return the registered Movie' do
      user = create(:user)
      api_movies_params = {title: 'Batman'}

      post '/import_movies', params: {movie: api_movies_params}, headers: get_headers(user)

      expect(json_body).to have_key(:movie)
      expect(json_body[:movie]).to have_key(:id)
      expect(json_body[:movie]).to have_key(:title)
      expect(json_body).to have_key(:category)
      expect(json_body[:category]).to have_key(:id)
      expect(json_body[:category]).to have_key(:name)

    end
  end
end

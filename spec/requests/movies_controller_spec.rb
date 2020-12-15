require "rails_helper"

RSpec.describe 'MoviesController', type: :request do
  describe "GET #index" do 
    it 'must return 200 http status code' do
      get '/movies'
      expect(response).to have_http_status(:ok) 
    end 

    it 'must return a list of movies' do
      category = Category.create(name: 'Ação')
      Movie.create(title: 'Velozes e Furiosos', description: 'foo', category_id: category.id)

      get '/movies'

      expect(json_body[0]).to have_key(:id)
    end
  end
end

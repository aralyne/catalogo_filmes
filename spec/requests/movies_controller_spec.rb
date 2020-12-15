require "rails_helper"

RSpec.describe 'MoviesController', type: :request do
  describe "GET #index" do 
    it 'must return 200 http status code' do
      get '/movies'
      expect(response).to have_http_status(:ok) 
    end 

    context "When to list registered films" do
      it 'must return a list of movies' do
        category = Category.create(name: 'Ação')
        Movie.create(title: 'Velozes e Furiosos', description: 'foo', category_id: category.id)
  
        get '/movies'
  
        expect(json_body[0]).to have_key(:id)
        expect(json_body[0]).to have_key(:title)
        expect(json_body[0]).to have_key(:description)
        expect(json_body[0]).to have_key(:category_id) 
      end
    end

    context "When not to list registered films" do
      it 'Inform the user that there are no films registered' do
          
        get '/movies'

        expect(json_body).to have_key(:message)
        expect(json_body[:message]).to eq("Empty list")
      end
    end
  end
end

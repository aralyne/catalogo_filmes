require "rails_helper"

RSpec.describe 'CategoriesController', type: :request do
  describe "GET #index" do 
    it 'must return 200 http status code' do
      get '/categories'
      expect(response).to have_http_status(:ok) 
    end 

    context "When to list registered categories" do
      it 'must return a list of categories' do
        Category.create(name: 'Romance')
         
        get '/categories'
  
        expect(json_body[0]).to have_key(:name)
      end
    end

    context "When not to list registered categories" do
      it 'Inform the user that there are no categories registered' do
          
        get '/categories'

        expect(json_body).to have_key(:message)
        expect(json_body[:message]).to eq("Empty list")
      end
    end
  end
end

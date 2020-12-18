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
      it 'Inform the category that there are no categories registered' do
          
        get '/categories'

        expect(json_body).to have_key(:message)
        expect(json_body[:message]).to eq("Empty list")
      end
    end
  end

  describe "GET #show" do

  it 'must return 200 http status code' do
    get '/categories'
    expect(response).to have_http_status(:ok) 
  end 

  context 'When to list a category' do
    it 'must return a category' do
      category = Category.create(name: 'Romance')

      get "/categories/#{category.id}"

      expect(json_body).to have_key(:name)
    end
  end
end

describe 'POST #create' do
  context 'when passing valid data' do
    it 'need to return status code 201' do
      category_params = {name: 'Romance'}
      post '/categories', params: {category: category_params}

      expect(response).to have_http_status(:created)
    end

    it 'need to return the registered category' do
      category_params = {name: 'Romance'}

      post '/categories', params: {category: category_params}

      expect(json_body).to have_key(:id)
      expect(json_body).to have_key(:name)
    end
  end 

  context 'when passing invalid data' do
    it 'must return 422 http status code' do
      category_params = {name: nil}

      post '/categories', params: {category: category_params}

      expect(json_body).to have_key(:errors)
      expect(json_body[:errors][:name][0]).to eq("can't be blank")
    end
  end
end

describe 'PUT #update' do
  context 'when passing valid data' do
    it 'must return 204 http status code' do
      category = Category.create(name: 'Romance')
      category_params = {name: 'Drama'}

      put "/categories/#{category.id}", params: {category: category_params}

      expect(response).to have_http_status(:no_content)
    end
  end 

  context 'when passing invalid data' do
    it 'must return 422 http status code' do
      category = Category.create(name: 'Romance')
      category_params = {name: nil}

      put "/categories/#{category.id}", params: {category: category_params}

      expect(json_body).to have_key(:errors)
      expect(json_body[:errors]).to have_key(:name)
      expect(json_body[:errors][:name][0]).to eq("can't be blank")
    end
  end
end

describe 'DELETE #destroy' do
  it 'must return 204 http status code' do
    category = Category.create(name:"Romance")

    delete "/categories/#{category.id}"

    expect(response).to have_http_status(:no_content)
  end
end 

end

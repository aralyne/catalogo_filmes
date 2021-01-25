require "rails_helper"

RSpec.describe 'UsersController', type: :request do
  describe "GET #index" do 
    it 'must return 200 http status code' do
      userauth = create(:user)

      get '/users', headers: get_headers(userauth)

      expect(response).to have_http_status(:ok)
    end

    context 'When to list registered users' do
      it 'must return a list of users' do
        userauth = create(:user)
        create(:user)

        get '/users', headers: get_headers(userauth)

        expect(json_body[0]).to have_key(:user)
        expect(json_body[0][:user]).to have_key(:name)
        expect(json_body[0][:user]).to have_key(:email)

      end
    end
  end

  describe "GET #show" do

    it 'must return 200 http status code' do
      user = create(:user)

      get '/users', headers: get_headers(user)

      expect(response).to have_http_status(:ok) 
    end 

    context 'When to list an user' do
      it 'must return an user' do
        userauth = create(:user)
        user = create(:user)

        get "/users/#{user.id}", headers: get_headers(userauth)

        expect(json_body).to have_key(:user)
        expect(json_body[:user]).to have_key(:id)
        expect(json_body[:user]).to have_key(:name)
      end
    end
  end

  describe 'POST #create' do
    context 'when passing valid data' do
      it 'need to return status code 201' do
        userauth = create(:user)
        user_params = attributes_for(:user) 
        address_params = attributes_for(:address)
        params = user_params.merge!(addresses_attributes:[address_params])
       
        post '/users', params: {user: params}, headers: get_headers(userauth)

        binding.pry
        expect(response).to have_http_status(:created)
      end

      it 'need to return the registered user' do
        userauth = create(:user)
        user_params = attributes_for(:user)

        post '/users', params: {user: user_params}, headers: get_headers(userauth)

        expect(json_body).to have_key(:user)
        expect(json_body[:user]).to have_key(:id)
        expect(json_body[:user]).to have_key(:name)
        expect(json_body[:user]).to have_key(:email)
      end
    end 

    context 'when passing invalid data' do
      it 'must return 422 http status code' do
        userauth = create(:user)
        user_params = attributes_for(:user, name: nil, email: nil)

        post '/users', params: {user: user_params}, headers: get_headers(userauth)

        expect(json_body).to have_key(:errors)
        expect(json_body[:errors][:name][0]).to eq("can't be blank")
        expect(json_body[:errors][:email][0]).to eq("can't be blank")
      end
    end
  end

  describe 'PUT #update' do
    context 'when passing valid data' do
      it 'must return 204 http status code' do
        userauth = create(:user)
        user = create(:user)
        user_params = attributes_for(:user)
        address_params = attributes_for(:address)
        params = user_params.merge!(addresses_attributes:[address_params])

        put "/users/#{user.id}", params: {user: params}, headers: get_headers(userauth)

        expect(response).to have_http_status(:no_content)
      end
    end 

    context 'when passing invalid data' do
      it 'must return 422 http status code' do
        userauth = create(:user)
        user = create(:user)
        user_params = attributes_for(:user, name: nil, email: nil)

        put "/users/#{user.id}", params: {user: user_params}, headers: get_headers(userauth)

        expect(json_body).to have_key(:errors)
        expect(json_body[:errors]).to have_key(:name)
        expect(json_body[:errors]).to have_key(:email)
        expect(json_body[:errors][:name][0]).to eq("can't be blank")
        expect(json_body[:errors][:email][0]).to eq("can't be blank")
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'must return 204 http status code' do
      userauth = create(:user)
      user = create(:user)

      delete "/users/#{user.id}", headers: get_headers(userauth)

      expect(response).to have_http_status(:no_content)
    end
  end 

end
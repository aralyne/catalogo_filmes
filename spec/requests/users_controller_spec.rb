require "rails_helper"

RSpec.describe 'UsersController', type: :request do
  describe "GET #index" do 
    it 'must return 200 http status code' do
      get '/users'

      expect(response).to have_http_status(:ok)
    end

    context 'When to list registered users' do
      it 'must return a list of users' do
        User.create(name: 'Kennya', email:'kennya@gmail.com')

        get '/users'

        expect(json_body[0]).to have_key(:name)
        expect(json_body[0]).to have_key(:email)
      end
    end

    context 'When not to list registered users' do
      it 'Inform the user that there are no users registered' do

        get '/users'

        expect(json_body).to have_key(:message)
        expect(json_body[:message]).to eq("Empty list")
      end
    end
  end

  describe "GET #show" do

    it 'must return 200 http status code' do
      get '/users'
      expect(response).to have_http_status(:ok) 
    end 

    context 'When to list an user' do
      it 'must return an user' do
        user = User.create(name: 'Diego', email:'diego@gmail.com')

        get "/users/#{user.id}"

        expect(json_body).to have_key(:name)
      end
    end
  end

  describe 'POST #create' do
    context 'when passing valid data' do
      it 'need to return status code 201' do
        user_params = {name: 'aralyne', email: 'aralynegs@gmail.com'}
        post '/users', params: {user: user_params}

        expect(response).to have_http_status(:created)
      end

      it 'need to return the registered user' do
        user_params = {name: 'aralyne', email: 'aralynegs@gmail.com'}

        post '/users', params: {user: user_params}

        expect(json_body).to have_key(:id)
        expect(json_body).to have_key(:name)
        expect(json_body).to have_key(:email)
      end
    end 

    context 'when passing invalid data' do
      it 'must return 422 http status code' do
        user_params = {name: nil, email: nil}

        post '/users', params: {user: user_params}

        expect(json_body).to have_key(:errors)
        expect(json_body[:errors][:name][0]).to eq("can't be blank")
        expect(json_body[:errors][:email][0]).to eq("can't be blank")
      end
    end
  end

  describe 'PUT #update' do
    context 'when passing valid data' do
      it 'must return 204 http status code' do
        user = User.create(name: 'Diego', email:'diego@gmail.com')
        user_params = {name: 'aralyne', email: 'aralynegs@gmail.com'}

        put "/users/#{user.id}", params: {user: user_params}

        expect(response).to have_http_status(:no_content)
      end
    end 

    context 'when passing invalid data' do
      it 'must return 422 http status code' do
        user = User.create(name: 'Diego', email:'diego@gmail.com')
        user_params = {name: nil, email: nil}

        put "/users/#{user.id}", params: {user: user_params}

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
      user = User.create(name:"aralyne", email:"aralyne@gmail.com")

      delete "/users/#{user.id}"

      expect(response).to have_http_status(:no_content)
    end
  end 

end
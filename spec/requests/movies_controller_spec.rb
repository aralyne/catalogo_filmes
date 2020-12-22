require "rails_helper"

RSpec.describe 'MoviesController', type: :request do

  describe "GET #index" do 
    it 'must return 200 http status code' do
      user = User.create(name:"Aralyne",email:"aralynegs@gmail.com",password:"123456789")

      get '/movies', headers: get_headers(user)

      expect(response).to have_http_status(:ok) 
    end 

    context "When to list registered films" do
      it 'must return a list of movies' do
        user = User.create(name:"Aralyne",email:"aralynegs@gmail.com",password:"123456789")
        category = Category.create(name: 'Ação')
        Movie.create(title: 'Velozes e Furiosos', description: 'foo', category_id: category.id)
  
        get '/movies', headers: get_headers(user)
        
        expect(json_body[0]).to have_key(:message)
        expect(json_body[0]).to have_key(:movie)
        expect(json_body[0][:movie]).to have_key(:id)
        expect(json_body[0][:movie]).to have_key(:title)
        expect(json_body[0][:movie]).to have_key(:description)
        expect(json_body[0]).to have_key(:category) 
        expect(json_body[0][:category]).to have_key(:id)
        expect(json_body[0][:category]).to have_key(:name)
        expect(json_body[0][:movie][:title]).to eq('Velozes e Furiosos')
        expect(json_body.size).to eq(1) #numero de objetos
      end
    end

    context "When not to list registered films" do
      it 'Inform the user that there are no films registered' do
        user = User.create(name:"Aralyne",email:"aralynegs@gmail.com",password:"123456789")
          
        get '/movies', headers: get_headers(user)

        expect(json_body).to have_key(:message)
        expect(json_body[:message]).to eq("Empty list")
      end
    end
  end

  describe "GET #show" do

    it 'must return 200 http status code' do
      user = User.create(name:"Aralyne",email:"aralynegs@gmail.com",password:"123456789")

      get '/movies', headers: get_headers(user)

      expect(response).to have_http_status(:ok) 
    end 

    context 'When to list a movie' do
      it 'must return an user' do
        user = User.create(name:"Aralyne",email:"aralynegs@gmail.com",password:"123456789")
        category = Category.create(name: 'Infantil')
        movie = Movie.create(title: 'Melhor que ontem', description: 'Bom', category_id: category.id)

        get "/movies/#{movie.id}", headers: get_headers(user)

        expect(json_body).to have_key(:message)
        expect(json_body).to have_key(:movie)
        expect(json_body[:movie]).to have_key(:id)
        expect(json_body[:movie]).to have_key(:title)
        expect(json_body[:movie]).to have_key(:description)
        expect(json_body[:movie]).to have_key(:created_at)
        expect(json_body).to have_key(:category) 
        expect(json_body[:category]).to have_key(:id)
        expect(json_body[:category]).to have_key(:name)
        expect(json_body[:movie][:title]).to eq('Melhor que ontem')
      end
    end
  end

  describe 'POST #create' do
    context 'when passing valid data' do
      it 'need to return status code 201' do
        user = User.create(name:"Aralyne", password:"123456789", email:"aralynegs@gmail.com")
        category = Category.create(name: 'Infantil')
        movie_params = {title: 'Melhor que ontem', description: 'Filme dirigido por Maria', category_id: category.id}
        
        post '/movies', params: {movie: movie_params}, headers: get_headers(user)

        expect(response).to have_http_status(:created)
      end

      it 'need to return the registered movie' do
        user = User.create(name:"Aralyne",email:"aralynegs@gmail.com",password:"123456789")
        category = Category.create(name: 'Infantil')
        movie_params = {title: 'Melhor que ontem', description: 'Filme dirigido por Maria', category_id: category.id}

        post '/movies', params: {movie: movie_params}, headers: get_headers(user)

        expect(json_body).to have_key(:id)
        expect(json_body).to have_key(:title)
        expect(json_body).to have_key(:description)
      end
    end 

    context 'when passing invalid data' do
      it 'must return 422 http status code' do
        user = User.create(name:"Aralyne",email:"aralynegs@gmail.com",password:"123456789")
        movie_params = {title: nil, description: nil, category_id: nil}

        post '/movies', params: {movie: movie_params}, headers: get_headers(user)

        expect(json_body).to have_key(:errors)
        expect(json_body[:errors][:title][0]).to eq("can't be blank")
        expect(json_body[:errors][:description][0]).to eq("can't be blank")
      end
    end
  end

  describe 'PUT #update' do
    context 'when passing valid data' do
      it 'must return 204 http status code' do
        user = User.create(name:"Aralyne", password:"123456789", email:"aralynegs@gmail.com")
        category = Category.create(name: 'Infantil')
        movie = Movie.create(title: 'De volta para o futuro 2', description:'Melhores', category_id: category.id)
        movie_params = {title: 'De volta para o futuro', description:'Melhores', category_id: category.id}

        put "/movies/#{movie.id}", params: {movie: movie_params}, headers: get_headers(user)

        expect(response).to have_http_status(:no_content)
      end
    end 

    context 'when passing invalid data' do
      it 'must return 422 http status code' do
        user = User.create(name:"Aralyne",email:"aralynegs@gmail.com",password:"123456789")
        category = Category.create(name: 'Infantil')
        movie = Movie.create(title: 'De volta para o futuro 2', description:'Melhores', category_id: category.id)
        movie_params = {title: nil, description: nil, category_id: nil}

        put "/movies/#{movie.id}", params: {movie: movie_params}, headers: get_headers(user)

        expect(json_body).to have_key(:errors)
        expect(json_body[:errors]).to have_key(:title)
        expect(json_body[:errors]).to have_key(:description)
        expect(json_body[:errors][:title][0]).to eq("can't be blank")
        expect(json_body[:errors][:description][0]).to eq("can't be blank")
      end
    end
  end

  describe 'DELETE #destroy' do
  it 'must return 204 http status code' do
    user = User.create(name:"Aralyne",email:"aralynegs@gmail.com",password:"123456789")
    category = Category.create(name: 'Infantil')
    movie = Movie.create(title: 'Melhor que ontem', description: 'Bom', category_id: category.id)

    delete "/movies/#{movie.id}", headers: get_headers(user)

    expect(response).to have_http_status(:no_content)
  end
end 

end

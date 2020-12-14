require "rails_helper"

RSpec.describe "MoviesController", type: :request do

    describe "GET #index" do 
        it "Must return 200 http status code" do
            get "/movies"
            expect(response).to have_http_status(:ok) 
        end 

       # it "" do
         #   get "/movies"
           # puts response
            # expect(response.body).to have_key("id")
       # end

    end

end


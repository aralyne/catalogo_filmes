require 'rails_helper'

RSpec.describe Omdb::Movie do 
  describe '#call' do 
    context 'Quando encontrar um filme' do
      it 'precisa retornar os dados do filme no seguinte formato' do
        api_movies_params = {title: 'Batman'}

        adapter = Omdb::Movie.new(api_movies_params).call

        expect(adapter).to have_key(:title)
        expect(adapter).to have_key(:description)
        expect(adapter).to have_key(:categories)
      end
    end
    context 'Quando o id do filme for vazio' do
      it 'Precisa retornar os seguintes dados' do
        api_movies_params = {title: nil}

        adapter = Omdb::Movie.new(api_movies_params).call

        expect(adapter).to have_key(:Error)
        expect(adapter[:Error]).to eq('Incorrect IMDb ID.')
      end
    end
    context 'Quando o nome do filme for inválido' do
      it 'Precisa retornar os seguintes dados' do
        api_movies_params = {title: 'Basdasdasdatmanasdas'}

        adapter = Omdb::Movie.new(api_movies_params).call

        expect(adapter).to have_key(:Error)
        expect(adapter[:Error]).to eq('Movie not found!')
      end
    end
  end
end

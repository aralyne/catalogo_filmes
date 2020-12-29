class Omdb::Movie
  def initialize(title)
    @title = 'title'
    @api_key = '7013373'
    @response = HTTParty.get("http://www.omdbapi.com/?t=#{@title}&apikey=#{@api_key}")
  end

  def call
    {
      title: @response['Title'], 
      description: @response['Plot'],
      categories: @response['Genre'].split(',')
    }
  end
end
class Omdb::Movie
  def initialize(params)
    @params = params[:title]
    @api_key = '7013373'
    @response = HTTParty.get("http://www.omdbapi.com/?t=#{@params}&apikey=#{@api_key}")
  end

  def call
    return success_response if @response['Response'] == 'True'

    error_response
  end

private

  def success_response
    {
      title: @response['Title'], 
      description: @response['Plot'],
      categories: @response['Genre'].split(',')
    }
  end

  def error_response
    {Response: @response['False'], Error: @response['Error']}
  end
end
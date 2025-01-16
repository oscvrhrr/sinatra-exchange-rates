require "sinatra"
require "sinatra/reloader"
require "dotenv/load"
require "http"
require "json"


get("/") do
  response = HTTP.get("https://api.exchangerate.host/list?access_key=#{ENV.fetch("API_KEY")}")
  parsed_data = JSON.parse(response)
  @currencies = parsed_data["currencies"]

  erb(:homepage)
end

get("/:currency") do 
  response = HTTP.get("https://api.exchangerate.host/list?access_key=#{ENV.fetch("API_KEY")}")
  parsed_data = JSON.parse(response)
  @currencies = parsed_data["currencies"]

  @selected_currency = params.fetch("currency")

 erb(:selected_currency)
end

get("/:currency/:convert_to") do 
  @converted_currency = params.fetch("convert_to")
  @selected_currency = params.fetch("currency")

  response = HTTP.get("https://api.exchangerate.host/convert?from=#{@selected_currency}&to=#{@converted_currency}&amount=1&access_key=#{ENV.fetch("API_KEY")}")
  parsed_data = JSON.parse(response)
  
  @result = parsed_data["result"]

  erb(:convert_to)
end

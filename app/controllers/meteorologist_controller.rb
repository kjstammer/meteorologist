require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

    plus_street_address=@street_address.gsub(/\s/,"+")
    url = "http://maps.googleapis.com/maps/api/geocode/json?address="+plus_street_address+"&sensor=false"
    parsed_data = JSON.parse(open(url).read)
    latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
    longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]
    
    lat_string = latitude.to_s
    long_string = longitude.to_s
     url = "https://api.darksky.net/forecast/796a129dd68998bad3bcf43fa1ca5909/"+lat_string+","+long_string
    parsed_data = JSON.parse(open(url).read)
    current_temp = parsed_data["currently"]["temperature"]
    current_sum = parsed_data["currently"]["summary"]
    sum_next_sixty_minutes = parsed_data["minutely"]["summary"]
    sum_next_sev_hrs = parsed_data["hourly"]["summary"]
    sum_next_sev_days = parsed_data["daily"]["summary"]

    @current_temperature = current_temp

    @current_summary = current_sum

    @summary_of_next_sixty_minutes = sum_next_sixty_minutes

    @summary_of_next_several_hours = sum_next_sev_hrs

    @summary_of_next_several_days = sum_next_sev_days

    render("meteorologist/street_to_weather.html.erb")
  end
end

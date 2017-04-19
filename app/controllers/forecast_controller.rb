require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("forecast/coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================

    url = "https://api.darksky.net/forecast/796a129dd68998bad3bcf43fa1ca5909/"+@lat+","+@lng
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

    render("forecast/coords_to_weather.html.erb")
  end
end

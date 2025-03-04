-- Client-Side Weather System
local WeatherSystem = {}

-- Current weather data
WeatherSystem.Current = {
    Weather = "clear",
    Temperature = 20,
    Humidity = 50,
    WindSpeed = 0,
}

-- Function to update weather visuals
function WeatherSystem.UpdateVisuals()
    if WeatherSystem.Current.Weather == "rain" then
        SetWeatherTypeNow("RAIN")
        SetRainLevel(1.0)
    elseif WeatherSystem.Current.Weather == "storm" then
        SetWeatherTypeNow("THUNDER")
        SetRainLevel(2.0)
    elseif WeatherSystem.Current.Weather == "tornado" then
        SetWeatherTypeNow("BLIZZARD")
    elseif WeatherSystem.Current.Weather == "fog" then
        SetWeatherTypeNow("FOG")
    elseif WeatherSystem.Current.Weather == "snow" then
        SetWeatherTypeNow("SNOW")
    else
        SetWeatherTypeNow("CLEAR")
    end
end

-- Function to send weather data to UI
function WeatherSystem.UpdateUI()
    SendNUIMessage({
        type = "updateWeather",
        weather = WeatherSystem.Current.Weather,
        temperature = WeatherSystem.Current.Temperature,
        humidity = WeatherSystem.Current.Humidity,
        windSpeed = WeatherSystem.Current.WindSpeed,
    })
end

-- Event to receive weather updates
RegisterNetEvent("Weather:Update")
AddEventHandler("Weather:Update", function(data)
    WeatherSystem.Current = data
    WeatherSystem.UpdateVisuals()
    WeatherSystem.UpdateUI() -- Update UI with new weather data
end)
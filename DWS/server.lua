-- Server-Side Weather System
local WeatherSystem = {}

-- Configuration
WeatherSystem.Config = {
    Seasons = { "spring", "summer", "autumn", "winter" },
    Locations = { "forest", "desert", "plains", "city" },
    WeatherTypes = { "clear", "rain", "storm", "tornado", "drought", "fog", "snow" },
    TransitionTime = 30000, -- 30 seconds for weather transitions
    ForecastDays = 5, -- Number of days in the forecast
}

-- Current state
WeatherSystem.Current = {
    Weather = "clear",
    Season = "spring",
    Location = "forest",
    Temperature = 20, -- Celsius
    Humidity = 50, -- Percentage
    WindSpeed = 0, -- km/h
}

-- Weather effects
WeatherSystem.Effects = {
    clear = { temperatureChange = 1, humidityChange = -1, windChange = 0 },
    rain = { temperatureChange = -2, humidityChange = 10, windChange = 5 },
    storm = { temperatureChange = -3, humidityChange = 15, windChange = 20 },
    tornado = { temperatureChange = -5, humidityChange = 20, windChange = 50 },
    drought = { temperatureChange = 5, humidityChange = -20, windChange = 10 },
    fog = { temperatureChange = -1, humidityChange = 30, windChange = 2 },
    snow = { temperatureChange = -10, humidityChange = 5, windChange = 5 },
}

-- Forecast data
WeatherSystem.Forecast = {}

-- Function to calculate weather based on season and location
function WeatherSystem.CalculateWeather()
    local seasonModifiers = {
        spring = { "clear", "rain", "fog" },
        summer = { "clear", "drought", "storm" },
        autumn = { "clear", "rain", "fog" },
        winter = { "snow", "clear", "storm" },
    }

    local locationModifiers = {
        forest = { "rain", "fog" },
        desert = { "clear", "drought" },
        plains = { "clear", "tornado" },
        city = { "clear", "rain", "fog" },
    }

    local possibleWeather = {}
    for _, weather in ipairs(seasonModifiers[WeatherSystem.Current.Season]) do
        table.insert(possibleWeather, weather)
    end
    for _, weather in ipairs(locationModifiers[WeatherSystem.Current.Location]) do
        table.insert(possibleWeather, weather)
    end

    -- Randomly select weather
    return possibleWeather[math.random(1, #possibleWeather)]
end

-- Function to update weather conditions
function WeatherSystem.UpdateConditions(newWeather)
    local effects = WeatherSystem.Effects[newWeather]
    WeatherSystem.Current.Temperature = WeatherSystem.Current.Temperature + effects.temperatureChange
    WeatherSystem.Current.Humidity = WeatherSystem.Current.Humidity + effects.humidityChange
    WeatherSystem.Current.WindSpeed = WeatherSystem.Current.WindSpeed + effects.windChange

    -- Clamp values to realistic ranges
    WeatherSystem.Current.Temperature = math.max(-20, math.min(40, WeatherSystem.Current.Temperature))
    WeatherSystem.Current.Humidity = math.max(0, math.min(100, WeatherSystem.Current.Humidity))
    WeatherSystem.Current.WindSpeed = math.max(0, math.min(100, WeatherSystem.Current.WindSpeed))
end

-- Function to generate forecast
function WeatherSystem.GenerateForecast()
    WeatherSystem.Forecast = {}
    for i = 1, WeatherSystem.Config.ForecastDays do
        WeatherSystem.Forecast[i] = {
            Weather = WeatherSystem.CalculateWeather(),
            Temperature = WeatherSystem.Current.Temperature + math.random(-5, 5),
            Humidity = WeatherSystem.Current.Humidity + math.random(-10, 10),
            WindSpeed = WeatherSystem.Current.WindSpeed + math.random(-5, 5),
        }
    end
end

-- Function to change weather
function WeatherSystem.ChangeWeather(newWeather)
    WeatherSystem.Current.Weather = newWeather
    WeatherSystem.UpdateConditions(newWeather)
    WeatherSystem.GenerateForecast()
    TriggerClientEvent("Weather:Update", -1, WeatherSystem.Current)
end

-- Initialize weather system
function WeatherSystem.Init()
    WeatherSystem.ChangeWeather(WeatherSystem.CalculateWeather())
end

-- Example: Change weather every 10 minutes
Citizen.CreateThread(function()
    WeatherSystem.Init()
    while true do
        Citizen.Wait(600000) -- 10 minutes
        WeatherSystem.ChangeWeather(WeatherSystem.CalculateWeather())
    end
end)

-- Player interaction: Summon rain
RegisterServerEvent("Weather:SummonRain")
AddEventHandler("Weather:SummonRain", function()
    WeatherSystem.ChangeWeather("rain")
end)
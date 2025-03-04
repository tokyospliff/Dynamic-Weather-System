-- Farming System
local FarmingSystem = {}

-- Plant data
FarmingSystem.Plants = {
    { type = "wheat", growth = 0, optimalTemp = 20, optimalHumidity = 60 },
    { type = "corn", growth = 0, optimalTemp = 25, optimalHumidity = 50 },
    { type = "potato", growth = 0, optimalTemp = 15, optimalHumidity = 70 },
}

-- Function to calculate growth rate
function FarmingSystem.CalculateGrowth(plant)
    local tempDiff = math.abs(WeatherSystem.Current.Temperature - plant.optimalTemp)
    local humidityDiff = math.abs(WeatherSystem.Current.Humidity - plant.optimalHumidity)
    local growthRate = 1.0 - (tempDiff * 0.01) - (humidityDiff * 0.01)
    return math.max(0, growthRate)
end

-- Function to update plant growth
function FarmingSystem.UpdateGrowth()
    for _, plant in ipairs(FarmingSystem.Plants) do
        local growthRate = FarmingSystem.CalculateGrowth(plant)
        plant.growth = plant.growth + growthRate
        print(plant.type .. " growth: " .. plant.growth)
    end
end

-- Example: Update growth every minute
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000) -- 1 minute
        FarmingSystem.UpdateGrowth()
    end
end)
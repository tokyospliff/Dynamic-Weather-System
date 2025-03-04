document.addEventListener("DOMContentLoaded", function() {
    // test
    window.addEventListener("message", function(event) {
        if (event.data.type === "updateWeather") {
            // update
            document.getElementById("weather").innerText = "Weather: " + event.data.weather;
            document.getElementById("temperature").innerText = "Temperature: " + event.data.temperature + "°C";
            document.getElementById("humidity").innerText = "Humidity: " + event.data.humidity + "%";
            document.getElementById("wind-speed").innerText = "Wind Speed: " + event.data.windSpeed + " km/h";
        }
    });
});
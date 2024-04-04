const String validGetCurrentWeatherResponse = '''{
    "coord": {
        "lon": 17.91,
        "lat": -32.8874
    },
    "weather": [
        {
            "id": 802,
            "main": "Clouds",
            "description": "scattered clouds",
            "icon": "03n"
        }
    ],
    "base": "stations",
    "main": {
        "temp": 16.86,
        "feels_like": 16.69,
        "temp_min": 16.86,
        "temp_max": 16.86,
        "pressure": 1015,
        "humidity": 80,
        "sea_level": 1015,
        "grnd_level": 1009
    },
    "visibility": 10000,
    "wind": {
        "speed": 10.28,
        "deg": 182,
        "gust": 15.53
    },
    "clouds": {
        "all": 33
    },
    "dt": 1712251799,
    "sys": {
        "type": 1,
        "id": 1943,
        "country": "ZA",
        "sunrise": 1712206935,
        "sunset": 1712248793
    },
    "timezone": 7200,
    "id": 3361934,
    "name": "Saldanha",
    "cod": 200
}''';

const String apiKeyErrorResponse = '''{
    "cod": 401,
    "message": "Invalid API key. Please see https://openweathermap.org/faq#error401 for more info."
}''';
const String weatherErrorResponse = '''{"cod": "400","message": "Nothing to geocode"}''';

const String weatherLatOrLonErrorResponse = '''{
    "cod": "400",
    "message": "wrong latitude"
}''';

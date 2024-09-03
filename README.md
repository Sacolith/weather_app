# weather_app

Description: A Flutter-based Weather App that provides current weather information, forecasts, location-based data, and alerts. The app demonstrates API integration, geolocation services, and dynamic UI updates.

Features: 
 Current Weather: Displays the weather for a specified location.
 Forecasts: Provides forecast for the next few days based on specified location.
 Location-based Data: Fetches weather based location entered.

Skills Demonstrated:
API Integration(weather api specifically)
Dynamic UI Updates
Custom Animations
Package Utilization

Project Structure:
Lib(
    main.dart,routes.dart,
Models(weather_model.dart),
Screens(forecast_screen.dart home_screendart, settngs_screen.dart),
Services(weather_service.dart),
Widgets(forecast_widget.dart,location_widget.dart,weather_widget.dart)
)

Installation and Setup
git clone https://github.com/Sacolith/weather_app
cd weather-app
flutter pub get
flutter run

Note: Api keys are in .env so you will have to use your own 

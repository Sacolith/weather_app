import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/design/colors.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/screens/forecast_screen.dart';
import 'package:weather_app/screens/settings_screen.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/widgets/weather_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  Weather? _weather;
  bool _isLoading = false;
  final WeatherService _weatherService = WeatherService();
  final TextEditingController _cityController = TextEditingController();
  
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _loadDefaultCity();

    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.5).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadDefaultCity() async {
    final prefs = await SharedPreferences.getInstance();
    final defaultCity = prefs.getString('defaultCity') ?? '';
    setState(() {
      _cityController.text = defaultCity;
    });
  }

  Future<void> _fetchWeather() async {
    setState(() {
      _isLoading = true;
    });

    try {
      Weather weather = await _weatherService.fetchWeather(_cityController.text);
      setState(() {
        _weather = weather;
        _animationController.forward(from: 0.0); // Start the animation
      });
    } catch (e) {
      debugPrint(e.toString());
      debugPrint(_cityController.text);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load weather data')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Route _getForecast() {
    return PageRouteBuilder<SlideTransition>(
      pageBuilder: (context, animation, secondaryAnimation) =>
          ForecastScreen(city: _cityController.text),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var tweenVal = Tween<Offset>(begin: const Offset(0.0, 1.5), end: Offset.zero);
        var curves = CurveTween(curve: Curves.ease);

        return SlideTransition(
          position: animation.drive(curves).drive(tweenVal),
          child: child,
        );
      },
    );
  }

  Route _settings() {
    return PageRouteBuilder<SlideTransition>(
      pageBuilder: (context, animation, secondaryAnimation) => const SettingScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var tweenControl = Tween<Offset>(begin: const Offset(1.5, 0.0), end: Offset.zero);
        var curve = CurveTween(curve: Curves.ease);
        return SlideTransition(
          position: animation.drive(curve).drive(tweenControl),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, _settings());
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Enter Your City',
                labelStyle: const TextStyle(color: Colors.white),
                filled: true,
                fillColor: Colors.black.withOpacity(0.8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 60),
            ElevatedButton(
              onPressed: _fetchWeather,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Cols.buttoncol,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text('Get Weather'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, _getForecast());
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text('Get Forecast'),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _weather != null
                    ? ScaleTransition(
                        scale: _scaleAnimation,
                        child: WeatherWidget(weather: _weather!),
                      )
                    : const Center(child: Text('Enter a city to get the weather')),
          ],
        ),
      ),
    );
  }
}

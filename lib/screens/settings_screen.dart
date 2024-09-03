import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String _temperatureUnit = 'Celsius';
  String _defaultCity = '';
  bool _notificationsEnabled = true;
  late TextEditingController _cityController;

  @override
  void initState() {
    super.initState();
    _cityController = TextEditingController();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _temperatureUnit = prefs.getString('temperatureUnit') ?? 'Celsius';
      _defaultCity = prefs.getString('defaultCity') ?? '';
      _notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
      _cityController.text = _defaultCity;
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('temperatureUnit', _temperatureUnit);
    await prefs.setString('defaultCity', _cityController.text);
    await prefs.setBool('notificationsEnabled', _notificationsEnabled);
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Temperature Unit',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Radio<String>(
                  value: 'Celsius',
                  groupValue: _temperatureUnit,
                  onChanged: (value) {
                    setState(() {
                      _temperatureUnit = value!;
                    });
                    _saveSettings();
                  },
                ),
                const Text('Celsius'),
                Radio<String>(
                  value: 'Fahrenheit',
                  groupValue: _temperatureUnit,
                  onChanged: (value) {
                    setState(() {
                      _temperatureUnit = value!;
                    });
                    _saveSettings();
                  },
                ),
                const Text('Fahrenheit')
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Default City',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter default city',
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Colors.black
              ),
              onChanged: (value) {
                _defaultCity = value;
                
                _saveSettings();
              },
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text(
              'Notifications',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SwitchListTile(
              title: const Text('Enable Notifications'),
              value: _notificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  _notificationsEnabled = value;
                });
                _saveSettings();
              },
            ),
          ],
        ),
      ),
    );
  }
}

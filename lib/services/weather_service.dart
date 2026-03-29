import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class WeatherService extends GetxService {
  final temperature = 0.obs;
  final isDay = true.obs;

  @override
  void onReady() {
    super.onReady();
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _setFallbackStatus();
        return;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _setFallbackStatus();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _setFallbackStatus();
        return;
      }

      // Try last known position first for speed
      Position? position = await Geolocator.getLastKnownPosition();

      // If no last known position, get current one
      position ??= await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low,
          timeLimit: const Duration(seconds: 5));

      final url = Uri.parse(
          'https://api.open-meteo.com/v1/forecast?latitude=${position.latitude}&longitude=${position.longitude}&current_weather=true');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final currentWeather = data['current_weather'];

        temperature.value = (currentWeather['temperature'] as num).round();
        isDay.value = currentWeather['is_day'] == 1;
      } else {
        _setFallbackStatus();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching weather: $e');
      }
      _setFallbackStatus();
    }
  }

  void _setFallbackStatus() {
    int hour = DateTime.now().hour;
    isDay.value = hour > 6 && hour < 18;
  }
}

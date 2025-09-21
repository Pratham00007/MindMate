import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PinService {
  static const String _pinKey = 'app_pin';
  static const String _pinEnabledKey = 'pin_enabled';

  // Hash the PIN for secure storage
  static String _hashPin(String pin) {
    var bytes = utf8.encode(pin);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  // Set PIN
  static Future<bool> setPin(String pin) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String hashedPin = _hashPin(pin);
      await prefs.setString(_pinKey, hashedPin);
      await prefs.setBool(_pinEnabledKey, true);
      return true;
    } catch (e) {
      print('Error setting PIN: $e');
      return false;
    }
  }

  // Verify PIN
  static Future<bool> verifyPin(String pin) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? storedHashedPin = prefs.getString(_pinKey);
      
      if (storedHashedPin == null) return false;
      
      String hashedPin = _hashPin(pin);
      return hashedPin == storedHashedPin;
    } catch (e) {
      print('Error verifying PIN: $e');
      return false;
    }
  }

  // Check if PIN is enabled
  static Future<bool> isPinEnabled() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_pinEnabledKey) ?? false;
    } catch (e) {
      print('Error checking PIN enabled: $e');
      return false;
    }
  }

  // Disable PIN
  static Future<bool> disablePin() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(_pinKey);
      await prefs.setBool(_pinEnabledKey, false);
      return true;
    } catch (e) {
      print('Error disabling PIN: $e');
      return false;
    }
  }

  // Check if PIN exists
  static Future<bool> hasPinSet() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString(_pinKey) != null;
    } catch (e) {
      print('Error checking PIN exists: $e');
      return false;
    }
  }
}
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyUserName = 'user_name';
  static const String _keyUserEmail = 'user_email';
  static const String _keyUserPassword = 'user_password';

  // Save user data locally
  static Future<void> saveUserData({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_keyIsLoggedIn, true);
      await prefs.setString(_keyUserName, name);
      await prefs.setString(_keyUserEmail, email);
      await prefs.setString(_keyUserPassword, password);
    } catch (e) {
      print('Error saving user data: $e');
    }
  }

  // Get saved user data
  static Future<Map<String, String>?> getUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool(_keyIsLoggedIn) ?? false;
      
      if (isLoggedIn) {
        final name = prefs.getString(_keyUserName) ?? '';
        final email = prefs.getString(_keyUserEmail) ?? '';
        final password = prefs.getString(_keyUserPassword) ?? '';
        
        return {
          'name': name,
          'email': email,
          'password': password,
        };
      }
      return null;
    } catch (e) {
      print('Error getting user data: $e');
      return null;
    }
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_keyIsLoggedIn) ?? false;
    } catch (e) {
      print('Error checking login status: $e');
      return false;
    }
  }

  // Sign out user
  static Future<void> signOut() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_keyIsLoggedIn, false);
      await prefs.remove(_keyUserName);
      await prefs.remove(_keyUserEmail);
      await prefs.remove(_keyUserPassword);
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  // Validate login credentials
  static Future<bool> validateLogin(String email, String password) async {
    try {
      final userData = await getUserData();
      if (userData != null) {
        return userData['email'] == email && userData['password'] == password;
      }
      return false;
    } catch (e) {
      print('Error validating login: $e');
      return false;
    }
  }

  // Check if email already exists
  static Future<bool> emailExists(String email) async {
    try {
      final userData = await getUserData();
      if (userData != null) {
        return userData['email'] == email;
      }
      return false;
    } catch (e) {
      print('Error checking email existence: $e');
      return false;
    }
  }
}

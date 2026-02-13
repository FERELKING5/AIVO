/// App Configuration
/// Centralized configuration for the AIVO application
class AppConfig {
  // App Info
  static const String appName = 'AIVO';
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';

  // API Configuration (for future use)
  static const String apiBaseUrl = 'https://api.aivo.app';
  static const int apiTimeout = 30000; // milliseconds
  static const int apiRetries = 3;

  // Features
  static const bool enableNotifications = true;
  static const bool enableOfflineMode = true;
  static const bool enableAnalytics = false;
  static const bool debugMode = false;

  // Cache Configuration
  static const int cacheDurationSeconds = 3600; // 1 hour
  static const int maxCacheSize = 100; // MB

  // Performance
  static const int pageSize = 20;
  static const int debounceDelayMs = 500;

  // Security
  static const bool enableBiometric = true;
  static const bool requirePinOnStartup = false;

  // Default language
  static const String defaultLanguage = 'en';
  static const List<String> supportedLanguages = ['en', 'fr', 'es'];
}

import 'package:supabase_flutter/supabase_flutter.dart';

/// 100% FREE Recommendation Service - Appelle juste les SQL RPC functions
/// Zéro TypeScript, zéro Edge Functions, zéro coûts
class RecommendationServiceFree {
  static final RecommendationServiceFree _instance =
      RecommendationServiceFree._internal();

  final supabase = Supabase.instance.client;

  factory RecommendationServiceFree() {
    return _instance;
  }

  RecommendationServiceFree._internal();

  /// GET HOME RECOMMENDATIONS
  /// Appelle: SELECT get_home_recommendations(...)
  Future<Map<String, List<Map>>> getHomeRecommendations({
    String? userId,
    String country = 'US',
    String? city,
    int limit = 20,
  }) async {
    try {
      final data = await supabase.rpc('get_home_recommendations', params: {
        'p_user_id': userId,
        'p_country': country,
        'p_city': city,
        'p_limit': limit,
      }) as List;

      // Group by section
      final result = <String, List<Map>>{};
      for (final item in data) {
        final section = item['section'] as String;
        result.putIfAbsent(section, () => []);
        result[section]!.add(item as Map);
      }

      return result;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  /// GET PRODUCT RECOMMENDATIONS
  /// Appelle: SELECT get_product_recommendations(...)
  Future<Map<String, List<Map>>> getProductRecommendations({
    required String productId,
    String? userId,
    String country = 'US',
    int limit = 20,
  }) async {
    try {
      final data = await supabase.rpc('get_product_recommendations', params: {
        'p_product_id': productId,
        'p_user_id': userId,
        'p_country': country,
        'p_limit': limit,
      }) as List;

      // Group by section
      final result = <String, List<Map>>{};
      for (final item in data) {
        final section = item['section'] as String;
        result.putIfAbsent(section, () => []);
        result[section]!.add(item as Map);
      }

      return result;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  /// GET CART RECOMMENDATIONS
  /// Appelle: SELECT get_cart_recommendations(...)
  Future<Map<String, List<Map>>> getCartRecommendations({
    String? userId,
    String country = 'US',
    int limit = 20,
  }) async {
    try {
      final data = await supabase.rpc('get_cart_recommendations', params: {
        'p_user_id': userId,
        'p_country': country,
        'p_limit': limit,
      }) as List;

      // Group by section
      final result = <String, List<Map>>{};
      for (final item in data) {
        final section = item['section'] as String;
        result.putIfAbsent(section, () => []);
        result[section]!.add(item as Map);
      }

      return result;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  /// SEARCH RECOMMENDATIONS
  /// Appelle: SELECT search_recommendations(...)
  Future<Map<String, List<Map>>> searchRecommendations({
    required String query,
    String? userId,
    int limit = 20,
  }) async {
    try {
      final data = await supabase.rpc('search_recommendations', params: {
        'p_query': query,
        'p_user_id': userId,
        'p_limit': limit,
      }) as List;

      // Group by section
      final result = <String, List<Map>>{};
      for (final item in data) {
        final section = item['section'] as String;
        result.putIfAbsent(section, () => []);
        result[section]!.add(item as Map);
      }

      return result;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  /// RECORD EVENT (view, dwell, add_to_cart, etc.)
  /// Appelle: SELECT record_event(...)
  Future<void> recordEvent({
    String? userId,
    String? sessionId,
    required String eventType,
    String? productId,
    String? query,
    int dwellMs = 0,
    String country = 'US',
    String? city,
  }) async {
    try {
      await supabase.rpc('record_event', params: {
        'p_user_id': userId,
        'p_session_id': sessionId,
        'p_event_type': eventType, // 'view', 'dwell', 'purchase', etc.
        'p_product_id': productId,
        'p_query': query,
        'p_dwell_ms': dwellMs,
        'p_country': country,
        'p_city': city,
      });
    } catch (e) {
      print('Error recording event: $e');
    }
  }
}

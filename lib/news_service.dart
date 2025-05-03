import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  final String apikey = '4a4c1b6e11514576b7613475cd98cda3';

  /// Map of category → language → search term for each category
  static const Map<String, Map<String, String>> _categoryQueries = {
    'technology': {
      'en': 'technology',
      'hi': 'टेक्नोलॉजी',
      'bn': 'প্রযুক্তি',
      'ta': 'தொழில்நுட்ப',
    },
    'business': {
      'en': 'business',
      'hi': 'व्यापार',
      'bn': 'ব্যবসা',
      'ta': 'வணிகம்',
    },
    'entertainment': {
      'en': 'entertainment',
      'hi': 'मनोरंजन',
      'bn': 'বিনোদন',
      'ta': 'படபிடிப்பு',
    },
    'general': {
      'en': '',
      'hi': '',
      'bn': '',
      'ta': '',
    },
    'health': {
      'en': 'health',
      'hi': 'स्वास्थ्य',
      'bn': 'স্বাস্থ্য',
      'ta': 'ஆரோக்கியம்',
    },
    'science': {
      'en': 'science',
      'hi': 'विज्ञान',
      'bn': 'বিজ্ঞান',
      'ta': 'அறிவியல்',
    },
    'sports': {
      'en': 'sports',
      'hi': 'खेल',
      'bn': 'খেলাধুলা',
      'ta': 'விளையாட்டு',
    },
    'agriculture': {
      'en': 'agriculture',
      'hi': 'कृषि',
      'bn': 'কৃষি',
      'ta': 'விவசாயம்',
    },
  };

  /// Fetch news using the /v2/everything endpoint.
  Future<List<dynamic>> fetchnews(String category, String language) async {
    try {
      // pick the correct search term for the selected category and language
      final query = _categoryQueries[category]?[language] ?? _categoryQueries[category]?['en'] ?? category;

      final uri = Uri.https(
        'newsapi.org',
        '/v2/everything',
        {
          'q': query,
          'language': language,
          'sortBy': 'publishedAt',
          'pageSize': '30',
          'apiKey': apikey,
        },
      );

      print('📰 Fetching: $uri');
      final response = await http.get(uri);

      print('📰 Status: ${response.statusCode}');
      if (response.statusCode != 200) {
        print('⚠️ Error Body: ${response.body}');
        return [];
      }

      final Map<String, dynamic> data = jsonDecode(response.body);
      return data['articles'] ?? [];
    } catch (e) {
      print('🔥 fetchnews error: $e');
      return [];
    }
  }
}

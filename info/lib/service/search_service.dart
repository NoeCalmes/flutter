
import 'package:http/http.dart' as http;
import 'package:info/model/search_model.dart';
import 'dart:convert';

class SearchService {

  static const String _baseUrl = 'https://jina-search-api.docteurseoo.workers.dev/search';

  Future search (String query) async {
    try {
      final url = Uri.parse('$_baseUrl?q=$query'); 
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List results = data['results'] ?? [];

        return results.map((json) => SearchResult.fromJson(json)).toList();
      }else {
         throw Exception('Erreur API');
      }
    }
    catch(e){ 
      throw Exception(e);
    }
  }
}
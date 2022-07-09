import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

// API call
Future getData() async {
  String url = "https://nursebrain.COM/wp-json/wp/v2/posts?_embed";
  var response =
      await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
  if (response.statusCode == 200) {
    var decodedData = json.decode(response.body);
    return decodedData;
  }
  return;
}

/*class Article {
  final String title;
  final String excerpt;
  final String link;

  Article({
    @required this.title,
    @required this.excerpt,
    @required this.link,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] as String,
      excerpt: json['excerpt'] as String,
      link: json['link'] as String,
    );
  }
}*/

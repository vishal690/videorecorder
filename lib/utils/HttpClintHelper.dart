import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpClientHelper {
  static dynamic Get(String Url,
      {ContentType contentType = ContentType.Json}) async {
    final response = await http.get(Uri.parse(Url));

    if (response.statusCode == 200) {
      if (contentType == ContentType.Json) {
        Map<String, dynamic> user = jsonDecode(response.body);
        return user;
      } else if (contentType == ContentType.string) {
        return response.body.toString();
      } else {
        return response.body;
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}

enum ContentType {
  Json, // data member 1
  string,
  yaml
}

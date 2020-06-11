import 'dart:convert';

import 'client.dart';

class SimpleClient extends HttpClient {
  Future<dynamic> fetchJson(String path,
      {Map<String, String> headers, Map<String, dynamic> custom}) async {
    return fetchResponse(path, headers: headers, custom: custom)
        .then((response) => json.decode(response.body.toString()));
  }
}

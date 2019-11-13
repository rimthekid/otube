import 'dart:io';

class Utils {
  static Future<bool> checkResourceExists(String url) async {
    final httpClient = HttpClient();
    final Uri resolved = Uri.base.resolve(url);
    final HttpClientRequest request = await httpClient.getUrl(resolved);
    final HttpClientResponse response = await request.close();
    return response.statusCode != HttpStatus.ok;
  }

  static String formatLikeCount(int number, { int floorValue = 1000 }) {
    return number > floorValue ? "${number ~/ 1000} k" : number.toString();
  }
}
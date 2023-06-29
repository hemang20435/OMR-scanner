import 'package:http/http.dart' as http;
import 'dart:convert';

class APINetworkService {
  //change this to your local ip address. The port should be the same as the one you set in the server
  final String _url = "http://192.168.45.184:8882";
  Future<dynamic> getPredictedResult(String key) async {
    try {
      final response = await http.get(Uri.parse("$_url/result/$key"));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } on http.ClientException catch (e) {
      return e.message;
    }
  }
}

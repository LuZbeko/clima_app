import 'dart:convert';

import 'package:http/http.dart' as http;


class NetworkHelper {
  NetworkHelper(this.url);
  final String url;

  Future getData() async {
    Uri urlParse = Uri.parse(url);

    http.Response response = await http.get(urlParse);
    if (response.statusCode == 200) {
      String data = response.body;
      var decoded = jsonDecode(data); 
      return decoded;
    } else {
      print(response.statusCode);
    }
  }

}
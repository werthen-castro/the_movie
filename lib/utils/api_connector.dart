import 'package:http/http.dart' as http;

class ApiConnector {

  int secondsTimeout = 15;

  Future<http.Response> apiGet(String url, {Map<String, String> headers,}) async {
    http.Response response;

    try {

      response = await http.get(
        url,
        headers: headers,
      ).timeout(Duration(seconds: this.secondsTimeout),
      );
    } catch (error, stackTrace) {

    }

    return response;
  }

  retry(future, delay) {
    Future.delayed(Duration(milliseconds: delay), () {
      future();
    });
  }


}

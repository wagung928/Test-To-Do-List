import 'package:http/http.dart' as http;
import 'package:pembekalan_flutter/utilities/networking/networking_response.dart';

class NetworkingConnector {
  //class yang menghandle semua jenis Req ke EndPoint ke API (Universal use)
  //GET Method
  Future<NetworkingResponse> getRequest(
      String url,
      String path,
      Map<String, String> headerRequest,
      Map<String, String> queryParameters) async {
    try {
      var urlGet = url.indexOf('https') != -1 //kalau bukan -1 berarti http
          ? Uri.https(
              url.substring(url.indexOf('//') + 2), path, queryParameters)
          : Uri.http(
              url.substring(url.indexOf('//') + 2), path, queryParameters);
//manggil response nya
      var response = await http.get(urlGet, headers: headerRequest);
      print('Networking Response : ${response.body}');
      return NetworkingSuccess(response.body, response.statusCode);
    } catch (exception) {
      print('Networking Exception : ${exception.toString()}');
      return NetworkingException(exception.toString());
    }
  }

  //POST Method
  Future<NetworkingResponse> postRequest(
      String url, Map<String, String> headerRequest, String bodyRequest) async {
    try {
      var response = await http.post(Uri.parse(url),
          headers: headerRequest, body: bodyRequest);

      //response
      print('Networking Response : ${response.body}');
      return NetworkingSuccess(response.body, response.statusCode);
    } catch (exception) {
      print('Networking Exception : ${exception.toString()}');
      return NetworkingException(exception.toString());
    }
  }
}

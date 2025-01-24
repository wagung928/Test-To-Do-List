class NetworkingResponse {
  // berfungsi sebagai callback networking connector

  //callbak Error/Exception
}

class NetworkingException extends NetworkingResponse {
  String message;
  NetworkingException(this.message);
}

class NetworkingSuccess extends NetworkingResponse {
  String? body;
  int statusCode;

  NetworkingSuccess(this.body, this.statusCode);
}

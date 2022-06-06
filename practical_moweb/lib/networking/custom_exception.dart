class CustomException implements Exception {
  final _message;
  final _prefix;

  CustomException([this._message, this._prefix]);

}

class FetchDataException extends CustomException {
  FetchDataException([String? message])
      : super(message,"");
}

class NoInternetException extends CustomException {
  NoInternetException([message]) : super(message, "");
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, "");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message, "");
}

class InvalidInputException extends CustomException {
  InvalidInputException([String? message]) : super(message, "");
}

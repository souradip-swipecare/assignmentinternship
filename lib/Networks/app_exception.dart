class Appexeption implements Exception {
  // ignore: prefer_typing_uninitialized_variables
  final _message;
  // ignore: prefer_typing_uninitialized_variables
  final _prefix;
  Appexeption([this._message, this._prefix]);
  @override
  String toString() {
    return '$_message$_prefix';
  }
}

class Internetexeption extends Appexeption {
  Internetexeption([String? message])
      : super(message, 'No internet Connection');
}

class Servereception extends Appexeption {
  Servereception([String? message]) : super(message, 'Server is busy');
}

class Requesttimeout extends Appexeption {
  Requesttimeout([String? message]) : super(message, 'Request Timeout');
}

class Invalidurlexeption extends Appexeption {
  Invalidurlexeption([String? message]) : super(message, 'Request Timeout');
}

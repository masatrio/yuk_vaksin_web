class GeneralException {
  final String stackTrace;

  GeneralException(this.stackTrace);
}

class UserNotFoundException {}

class InvalidCredentialException {}

class UserAlreadyRegistered {}

//login execptions
class InvalidEmailAuthException implements Exception {}

class InvalidLoginCredentialsAuthException implements Exception {}

class TooManyRequestAuthException implements Exception {}

//register exeptions

class WeakPasswordAuthException implements Exception {}

class EmailAlreadyInUseAuthException implements Exception {}

// generic exceptions
class GenericAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {}

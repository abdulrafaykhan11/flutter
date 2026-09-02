// Login Exception
class UserNotFoundAuthException implements Exception{}
class WeakPasswordAuthException implements Exception{}

// Register Exception
class WrongPasswordAuthException implements Exception{}
class EmailAlreadyInUseAuthException implements Exception{}
class InvalidEmailAuthException implements Exception{}

// Generic Exception
class GenericAuthException implements Exception{}
class UserNotLoggedInAuthException implements Exception{}
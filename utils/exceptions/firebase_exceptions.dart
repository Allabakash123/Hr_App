class TFirebaseException implements Exception{
  final String code;
  TFirebaseException(this.code);

  String get message{
    switch(code){
      case 'unknown':
        return 'An unknown Firebase error occured. Please try again';
      case 'invalid-custom-token':
        return 'The custom token format is incorrect. Please check your custom token';
      case 'custom-token-mismatch':
        return 'The custom token corresponds to a different audience';
      case 'user-disabled':
        return 'The user account has been disabled';
      case 'user-not-found':
        return 'to user found for the given email or UID';
      case 'invalid-email':
        return 'The email address is already provided is invalid. Pleas enter a valid email';
      case 'email-already-in-use':
        return 'The email address is already registered. Please use a different email';
      case 'wrong-password':
        return 'The passoword is too weak. Please enter a strong passowrd';
      case 'keychain-error':
        return 'The app is not authorized to use Firebase Authentication with the provided API key.';
       default:
        return 'An unknown error occurred: $code';
    }
  }
}
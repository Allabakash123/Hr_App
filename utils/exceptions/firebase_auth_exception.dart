class TFirebaseAuthException implements Exception{
  final String code;
  
  TFirebaseAuthException(this.code);

  String get message{
    switch(code){
      case 'email-already-in-use':
        return 'email-already registered. Please use a different email';
      case 'invalid-email':
        return 'The email address provided is invalid. Please enter a valid email';
      case 'weak-password':
        return 'The password is too weak. Please choose a strong password';
      case 'User-disabled':
        return 'This user account has been disabled. Please contact support for assistance';
      case 'user-not-found':
        return 'Invalid login details. User not found';
      case 'wrong-password':
        return 'Incorrect password. Please check your password and enter again';
      case 'invalid-verification-code':
        return 'Invalid verification code. Please enter a valid code';
      case 'invalid-verification-id':
        return 'Invalid verification ID. Please request a new verification code';
      case 'quota-exceeded':
        return 'Quota exceeded. Please try again later';
      case 'email-already-existed':
        return 'The email address already exists. Please use a different email';
       default:
        return 'An unknown error occurred: $code';
    }
  }
}
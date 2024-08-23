class TPlatformException implements Exception{
  final String code;
  TPlatformException(this.code);
  String get message{
    switch(code){
      case 'INVALID-LOGIN-CREDENTIALS':
        return 'Invalid login credentials. Please double-check your information';
      case 'too-many-request':
        return 'Too many request. Please try again later';
      case 'invalid-argument':
        return 'Invalid argument provided to the authentication method.';
      default:
        return 'An unknown error occurred: $code';

    }
  }
}
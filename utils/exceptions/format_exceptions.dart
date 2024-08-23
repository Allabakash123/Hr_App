class TFormatException implements Exception{
  final String message;
  const TFormatException([this.message='An unexpected format error occured. please check your input']);

  factory TFormatException.fromMessge(String message){
    return TFormatException(message);
  }

  String get formattedMessage=>message;
  factory TFormatException.fromCode(String code){
    switch (code){
      case 'invalid-email-format':
        return const TFormatException('The email address format is invalid. please enter a valid email');
      case 'invalid-phone-number-format':
        return const TFormatException('The provided phone number format is invalid. Please entere a valid number.');
      
       default:
        return const TFormatException('An unknown error occurred:');
    }
  }
}
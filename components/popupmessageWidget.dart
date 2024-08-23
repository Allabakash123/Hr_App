import 'package:flutter/material.dart';

class PopupMessageWidget extends StatelessWidget {
  const PopupMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Account Activation Pending'),
      content: const Text('Your account is pending activation by the admin. You will receive an email notification once your account is active.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}

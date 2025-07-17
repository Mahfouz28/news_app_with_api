import 'package:flutter/material.dart';

class SocialLoginSection extends StatelessWidget {
  final String facebookLabel;
  final String googleLabel;
  final VoidCallback onFacebookTap;
  final VoidCallback onGoogleTap;

  final String questionText;
  final String actionText;
  final VoidCallback onActionTap;

  const SocialLoginSection({
    super.key,
    required this.facebookLabel,
    required this.googleLabel,
    required this.onFacebookTap,
    required this.onGoogleTap,
    required this.questionText,
    required this.actionText,
    required this.onActionTap,
    required Null Function() onSignUpTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("or continue with"),
        const SizedBox(height: 16),

        // Facebook & Google Buttons
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 50,
                child: TextButton.icon(
                  onPressed: onFacebookTap,
                  icon: Image.asset(
                    'assets/Facebookicon.png',
                    height: 20,
                    width: 20,
                  ),
                  label: Text(facebookLabel),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.grey[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SizedBox(
                height: 50,
                child: TextButton.icon(
                  onPressed: onGoogleTap,
                  icon: Image.asset(
                    'assets/Googelicone.png',
                    height: 20,
                    width: 20,
                  ),
                  label: Text(googleLabel),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.grey[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // Bottom Text
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(questionText),
            TextButton(
              onPressed: onActionTap,
              child: Text(
                actionText,
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

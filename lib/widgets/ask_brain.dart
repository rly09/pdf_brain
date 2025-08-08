import 'package:flutter/material.dart';

class AskBrain extends StatelessWidget {
  const AskBrain({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Positioned(
      bottom: 90,
      right: 20,
      child: GestureDetector(
        onTap: () {
          // TODO: Replace with your chatbot logic later
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("🧠 Chatbot will be added soon!")),
          );
        },
        child: Container(
          padding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.95),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    // adjust for more/less rounding
                    child: Image.asset(
                      'assets/icons/brain_icon.png',
                      width: 28,
                      height: 28,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Ask Brain",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

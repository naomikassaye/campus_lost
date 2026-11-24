import 'package:flutter/material.dart';

class ReportSubmitButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isSubmitting;

  const ReportSubmitButton({
    super.key,
    required this.onPressed,
    this.isSubmitting = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: isSubmitting ? null : onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: isSubmitting
            ? const CircularProgressIndicator()
            : const Text(
                'Submit Report',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
      ),
    );
  }
}

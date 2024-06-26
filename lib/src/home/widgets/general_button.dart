import 'package:flutter/material.dart';

class GeneralButton extends StatelessWidget {
  const GeneralButton({
    super.key,
    this.buttonWidth,
    required this.buttonIcon,
    required this.buttonDescription,
    required this.onPressedFunction,
    this.buttonColor,
    this.buttonForegroundColor,
  });

  final double? buttonWidth;
  final IconData buttonIcon;
  final String buttonDescription;
  final void Function() onPressedFunction;
  final Color? buttonColor;
  final Color? buttonForegroundColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        width: buttonWidth,
        child: ElevatedButton.icon(
          icon: FittedBox(child: Icon(buttonIcon)),
          label: FittedBox(
            child: Text(buttonDescription),
          ),
          onPressed: onPressedFunction,
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            foregroundColor: buttonForegroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ),
    );
  }
}

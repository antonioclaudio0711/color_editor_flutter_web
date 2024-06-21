import 'package:color_editor_flutter/shared/store/app_store.dart';
import 'package:flutter/material.dart';

class CustomDeviceButton extends StatelessWidget {
  const CustomDeviceButton({
    super.key,
    required this.appStore,
    required this.buttonDescription,
    required this.buttonIcon,
  });

  final AppStore appStore;
  final String buttonDescription;
  final IconData buttonIcon;

  @override
  Widget build(BuildContext context) {
    final secondaryColor = appStore.secondaryColor.value;

    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 40, right: 40),
      child: ValueListenableBuilder(
        valueListenable: appStore.tertiaryColor,
        builder: (context, tertiaryColor, widget) => SizedBox(
          width: double.maxFinite,
          child: ElevatedButton.icon(
            icon: Icon(
              buttonIcon,
              color: secondaryColor,
            ),
            label: FittedBox(
              child: Text(
                buttonDescription,
                style: TextStyle(color: secondaryColor),
              ),
            ),
            onPressed: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => appStore.colorPicker(
                  context: context,
                  currentColor: tertiaryColor,
                  colorFunction: (color) =>
                      appStore.setTertiaryColor(newTertiaryColor: color),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: tertiaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

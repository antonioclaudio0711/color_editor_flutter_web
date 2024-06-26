import 'package:color_editor_flutter/shared/store/app_store.dart';
import 'package:flutter/material.dart';

class ColorRepresentationWidget extends StatelessWidget {
  const ColorRepresentationWidget({
    super.key,
    required this.valueListenable,
    required this.appStore,
    required this.textDescriptionRow,
  });

  final ValueNotifier valueListenable;
  final AppStore appStore;
  final String textDescriptionRow;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: valueListenable,
      builder: (context, color, widget) {
        return Row(
          children: [
            GestureDetector(
              onTap: () => showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => appStore.colorPicker(
                  context: context,
                  currentColor: color,
                  textDescriptionColor: 'Select the $textDescriptionRow!',
                  colorFunction: (color) {
                    if (textDescriptionRow == 'Primary color') {
                      return appStore.setPrimaryColor(newPrimaryColor: color);
                    } else if (textDescriptionRow == 'Secondary color') {
                      return appStore.setSecondaryColor(
                          newSecondaryColor: color);
                    } else {
                      return appStore.setTertiaryColor(newTertiaryColor: color);
                    }
                  },
                ),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width / 50,
                height: MediaQuery.of(context).size.height / 20,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(width: 0.5),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(textDescriptionRow),
          ],
        );
      },
    );
  }
}

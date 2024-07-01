import 'package:color_editor_flutter/shared/store/app_store.dart';
import 'package:flutter/material.dart';

class FontRepresentationWidget extends StatelessWidget {
  const FontRepresentationWidget({super.key, required this.appStore});

  final AppStore appStore;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: appStore.currentTemplate,
      builder: (context, templateNumber, widget) {
        return templateNumber == 1
            ? FittedBox(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 5),
                  child: Row(
                    children: [
                      const Text('Selected text font style:'),
                      GestureDetector(
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) => appStore.fontPicker(),
                        ),
                        child: ValueListenableBuilder(
                          valueListenable: appStore.fontTextStyle,
                          builder: (context, textStyle, widget) {
                            return FittedBox(
                              child: Container(
                                margin: const EdgeInsets.only(left: 10),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 0.5),
                                  borderRadius: BorderRadius.circular(35),
                                ),
                                child: Text(
                                  textStyle.fontFamilyFallback![0],
                                  style: textStyle.copyWith(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container();
      },
    );
  }
}

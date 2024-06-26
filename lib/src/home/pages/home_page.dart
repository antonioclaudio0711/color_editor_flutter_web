import 'dart:convert';

import 'package:color_editor_flutter/shared/app_colors.dart';
import 'package:color_editor_flutter/shared/models/color_model.dart';
import 'package:color_editor_flutter/shared/store/app_store.dart';
import 'package:color_editor_flutter/shared/models/page_information_model.dart';
import 'package:color_editor_flutter/src/home/widgets/color_representation_widget.dart';
import 'package:color_editor_flutter/src/home/widgets/custom_device_button.dart';
import 'package:color_editor_flutter/src/home/widgets/feedback_container.dart';
import 'package:color_editor_flutter/src/home/widgets/general_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AppStore _appStore = AppStore();
  final AppColors _appColors = AppColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: const Text('Edit Tool'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder(
              valueListenable: _appStore.primaryColor,
              builder: (context, primaryColor, widget) {
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => _appStore.colorPicker(
                        context: context,
                        currentColor: primaryColor,
                        textDescriptionColor: 'Select the Primary color!',
                        colorFunction: (color) =>
                            _appStore.setPrimaryColor(newPrimaryColor: color),
                      ),
                    );
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      border: Border.all(width: 15),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: ValueListenableBuilder(
                      valueListenable: _appStore.secondaryColor,
                      builder: (context, secondaryColor, widget) =>
                          GestureDetector(
                        onTap: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => _appStore.colorPicker(
                              context: context,
                              currentColor: secondaryColor,
                              textDescriptionColor:
                                  'Select the Secondary color!',
                              colorFunction: (color) => _appStore
                                  .setSecondaryColor(newSecondaryColor: color),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 17,
                          ),
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(35),
                              bottomRight: Radius.circular(35),
                            ),
                          ),
                          child: ValueListenableBuilder(
                            valueListenable: _appStore.currentTemplate,
                            builder: (context, templateNumber, widget) =>
                                Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (templateNumber == 1)
                                  //TODO: Fazer a customização da fonte (cor e tipo da fonte)
                                  GestureDetector(
                                    onTap: () => print('Text'),
                                    child: FittedBox(
                                      child: Text(
                                        'ShowUp',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayLarge,
                                      ),
                                    ),
                                  ),
                                if (templateNumber == 2)
                                  ValueListenableBuilder(
                                    valueListenable: _appStore.image64String,
                                    builder: (context, image, widget) =>
                                        GestureDetector(
                                      onTap: () =>
                                          _appStore.pickAndConvertImage(),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                8,
                                        child: image ==
                                                'assets/images/show_up_logo.png'
                                            ? Image.asset(
                                                image,
                                              )
                                            : Image.memory(
                                                base64Decode(image),
                                              ),
                                      ),
                                    ),
                                  ),
                                const SizedBox(height: 20),
                                CustomDeviceButton(
                                  appStore: _appStore,
                                  buttonDescription: 'Activate Kiosk',
                                  buttonIcon: Icons.person_add,
                                ),
                                CustomDeviceButton(
                                  appStore: _appStore,
                                  buttonDescription: 'Activate Session Scanner',
                                  buttonIcon: Icons.qr_code_scanner,
                                ),
                                CustomDeviceButton(
                                  appStore: _appStore,
                                  buttonDescription: 'Activate Leads',
                                  buttonIcon: Icons.people_alt,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(width: 50),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width / 4,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 0.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GeneralButton(
                    buttonIcon: Icons.restore,
                    buttonDescription: 'Restore to initial settings',
                    onPressedFunction: () => _appStore.resetToInitialSettings(),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 5),
                    child: Text('Choose one of these templates:'),
                  ),
                  GeneralButton(
                    buttonWidth: double.maxFinite,
                    buttonIcon: Icons.fit_screen,
                    buttonDescription:
                        'Template 1 - Text, backgroundColor and input',
                    onPressedFunction: () =>
                        _appStore.setTemplate(newTemplate: 1),
                  ),
                  GeneralButton(
                    buttonWidth: double.maxFinite,
                    buttonIcon: Icons.fit_screen,
                    buttonDescription:
                        'Template 2 - Image, backgroundColor and input',
                    onPressedFunction: () =>
                        _appStore.setTemplate(newTemplate: 2),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 5),
                    child: Text('Selected colors:'),
                  ),
                  ColorRepresentationWidget(
                    valueListenable: _appStore.primaryColor,
                    appStore: _appStore,
                    textDescriptionRow: 'Primary color',
                  ),
                  ColorRepresentationWidget(
                    valueListenable: _appStore.secondaryColor,
                    appStore: _appStore,
                    textDescriptionRow: 'Secondary color',
                  ),
                  ColorRepresentationWidget(
                    valueListenable: _appStore.tertiaryColor,
                    appStore: _appStore,
                    textDescriptionRow: 'Tertiary color',
                  ),
                  const Spacer(),
                  ValueListenableBuilder(
                    valueListenable: _appStore.isVisible,
                    builder: (context, visibility, child) => visibility
                        ? FeedbackContainer(appStore: _appStore)
                        : Container(),
                  ),
                  GeneralButton(
                    buttonWidth: double.maxFinite,
                    buttonIcon: Icons.import_export,
                    buttonDescription: 'Export information',
                    onPressedFunction: () async =>
                        await _appStore.postPageInformation(
                      pageInformation: PageInformationModel(
                        templateNumber: _appStore.currentTemplate.value,
                        primaryColor: ColorModel(
                          redIndex: _appStore.primaryColor.value.red,
                          blueIndex: _appStore.primaryColor.value.blue,
                          greenIndex: _appStore.primaryColor.value.green,
                          alphaIndex: _appStore.primaryColor.value.alpha,
                        ),
                        secondaryColor: ColorModel(
                          redIndex: _appStore.secondaryColor.value.red,
                          blueIndex: _appStore.secondaryColor.value.blue,
                          greenIndex: _appStore.secondaryColor.value.green,
                          alphaIndex: _appStore.secondaryColor.value.alpha,
                        ),
                        tertiaryColor: ColorModel(
                          redIndex: _appStore.tertiaryColor.value.red,
                          blueIndex: _appStore.tertiaryColor.value.blue,
                          greenIndex: _appStore.tertiaryColor.value.green,
                          alphaIndex: _appStore.tertiaryColor.value.alpha,
                        ),
                        imageFilePath: _appStore.image64String.value,
                      ),
                    ),
                    buttonColor: _appColors.exportButtonBackgroundColor,
                    buttonForegroundColor: _appColors.whiteForegroundColor,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:color_editor_flutter/shared/app_colors.dart';
import 'package:color_editor_flutter/shared/store/app_store.dart';
import 'package:color_editor_flutter/shared/models/page_informations_model.dart';
import 'package:color_editor_flutter/src/home/widgets/custom_device_button.dart';
import 'package:color_editor_flutter/src/home/widgets/feedback_container.dart';
import 'package:color_editor_flutter/src/home/widgets/general_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  final AppStore _appStore = AppStore();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AppStore get appStore => widget._appStore;
  final AppColors appColors = AppColors();

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
              valueListenable: appStore.primaryColor,
              builder: (context, primaryColor, widget) {
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => appStore.colorPicker(
                        context: context,
                        currentColor: primaryColor,
                        colorFunction: (color) =>
                            appStore.setPrimaryColor(newPrimaryColor: color),
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
                      valueListenable: appStore.secondaryColor,
                      builder: (context, secondaryColor, widget) =>
                          GestureDetector(
                        onTap: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => appStore.colorPicker(
                              context: context,
                              currentColor: secondaryColor,
                              colorFunction: (color) => appStore
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
                            valueListenable: appStore.currentTemplate,
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
                                    valueListenable: appStore.imageFile,
                                    builder: (context, file, widget) =>
                                        GestureDetector(
                                      onTap: () => appStore.imagePicker(),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                8,
                                        child: Image.network(file.path),
                                      ),
                                    ),
                                  ),
                                const SizedBox(height: 20),
                                CustomDeviceButton(
                                  appStore: appStore,
                                  buttonDescription: 'Activate Kiosk',
                                  buttonIcon: Icons.person_add,
                                ),
                                CustomDeviceButton(
                                  appStore: appStore,
                                  buttonDescription: 'Activate Session Scanner',
                                  buttonIcon: Icons.qr_code_scanner,
                                ),
                                CustomDeviceButton(
                                  appStore: appStore,
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
                    onPressedFunction: () => appStore.resetToInitialSettings(),
                  ),
                  const SizedBox(height: 30),
                  const Text('Choose one of these templates:'),
                  const SizedBox(height: 5),
                  GeneralButton(
                    buttonWidth: double.maxFinite,
                    buttonIcon: Icons.fit_screen,
                    buttonDescription:
                        'Template 1 - Text, backgroundColor and input',
                    onPressedFunction: () =>
                        appStore.setTemplate(newTemplate: 1),
                  ),
                  const SizedBox(height: 10),
                  GeneralButton(
                    buttonWidth: double.maxFinite,
                    buttonIcon: Icons.fit_screen,
                    buttonDescription:
                        'Template 2 - Image, backgroundColor and input',
                    onPressedFunction: () =>
                        appStore.setTemplate(newTemplate: 2),
                  ),
                  const Spacer(),
                  ValueListenableBuilder(
                    valueListenable: appStore.isVisible,
                    builder: (context, visibility, child) => visibility
                        ? FeedbackContainer(appStore: appStore)
                        : Container(),
                  ),
                  GeneralButton(
                    buttonWidth: double.maxFinite,
                    buttonIcon: Icons.import_export,
                    buttonDescription: 'Export informations',
                    onPressedFunction: () async =>
                        await appStore.postPageInformations(
                      pageInformations: PageInformationsModel(
                        templateNumber: appStore.currentTemplate.value,
                        primaryColor: appStore.primaryColor.value,
                        secondaryColor: appStore.secondaryColor.value,
                        tertiaryColor: appStore.tertiaryColor.value,
                        imageFilePath: appStore.imageFile.value.path,
                      ),
                    ),
                    buttonColor: appColors.exportButtonBackgroundColor,
                    buttonForegroundColor: appColors.whiteForegroundColor,
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

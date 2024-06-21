import 'dart:async';
import 'dart:io';

import 'package:color_editor_flutter/shared/app_colors.dart';
import 'package:color_editor_flutter/shared/services/app_service.dart';
import 'package:color_editor_flutter/shared/models/page_informations_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';

class AppStore {
  AppStore();

  final AppService _appService = AppService();

  ValueNotifier<Color> primaryColor =
      ValueNotifier(AppColors().initialPrimaryColor);
  ValueNotifier<Color> secondaryColor =
      ValueNotifier(AppColors().initialSecondaryColor);
  ValueNotifier<Color> tertiaryColor =
      ValueNotifier(AppColors().initialTertiaryColor);
  ValueNotifier<File> imageFile = ValueNotifier(
    File('assets/images/show_up_logo.png'),
  );
  ValueNotifier<int> currentTemplate = ValueNotifier(1);
  ValueNotifier<bool> isVisible = ValueNotifier(false);
  ValueNotifier<String?> exportFeedBackDescription = ValueNotifier(null);

  final ImagePicker _picker = ImagePicker();

  void resetToInitialSettings() {
    setTemplate(newTemplate: 1);
    setPrimaryColor(newPrimaryColor: AppColors().initialPrimaryColor);
    setSecondaryColor(newSecondaryColor: AppColors().initialSecondaryColor);
    setTertiaryColor(newTertiaryColor: AppColors().initialTertiaryColor);
    setImageFile(newImageFile: File('assets/images/show_up_logo.png'));
  }

  void setPrimaryColor({required Color newPrimaryColor}) {
    if (newPrimaryColor == primaryColor.value) {
      return;
    } else {
      primaryColor.value = newPrimaryColor;
    }
  }

  void setSecondaryColor({required Color newSecondaryColor}) {
    if (newSecondaryColor == secondaryColor.value) {
      return;
    } else {
      secondaryColor.value = newSecondaryColor;
    }
  }

  void setTertiaryColor({required Color newTertiaryColor}) {
    if (newTertiaryColor == tertiaryColor.value) {
      return;
    } else {
      tertiaryColor.value = newTertiaryColor;
    }
  }

  Widget colorPicker({
    required BuildContext context,
    required Color currentColor,
    required void Function(Color) colorFunction,
  }) {
    return AlertDialog(
      title: const Text('Pick a color!'),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: currentColor,
          onColorChanged: colorFunction,
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Got it!'),
        )
      ],
    );
  }

  void setImageFile({required File newImageFile}) {
    if (newImageFile == imageFile.value) {
      return;
    } else {
      imageFile.value = newImageFile;
    }
  }

  Future<void> imagePicker() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setImageFile(newImageFile: File(pickedFile.path));
    }
  }

  void setTemplate({required int newTemplate}) {
    if (newTemplate == currentTemplate.value) {
      return;
    } else {
      currentTemplate.value = newTemplate;
    }
  }

  void setExportFeedbackDescription(
      {required String newExportFeedBackDescription}) {
    if (newExportFeedBackDescription == exportFeedBackDescription.value) {
      return;
    } else {
      exportFeedBackDescription.value = newExportFeedBackDescription;
    }
  }

  void setIsVisible({required bool newVisibility}) {
    if (newVisibility == isVisible.value) {
      return;
    } else {
      isVisible.value = newVisibility;
    }
  }

  Future<void> postPageInformations({
    required PageInformationsModel pageInformations,
  }) async {
    final codeStatusResponse = await _appService.postPageInformations(
      pageInformations: pageInformations,
    );

    if (codeStatusResponse == 200) {
      setExportFeedbackDescription(
          newExportFeedBackDescription: 'Exportation success!');

      resetToInitialSettings();
    } else {
      setExportFeedbackDescription(
          newExportFeedBackDescription: 'Exportation failed!');
    }

    setIsVisible(newVisibility: true);

    Timer(
      const Duration(seconds: 3),
      () => setIsVisible(newVisibility: false),
    );
  }
}

import 'dart:async';
import 'dart:html' as html;

import 'package:color_editor_flutter/shared/app_colors.dart';
import 'package:color_editor_flutter/shared/app_fonts.dart';
import 'package:color_editor_flutter/shared/models/page_information_model.dart';
import 'package:color_editor_flutter/shared/services/app_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_font_picker/flutter_font_picker.dart';

class AppStore {
  AppStore();

  final AppService _appService = AppService();
  final AppFonts _appFonts = AppFonts();

  ValueNotifier<Color> primaryColor =
      ValueNotifier(AppColors().initialPrimaryColor);
  ValueNotifier<Color> secondaryColor =
      ValueNotifier(AppColors().initialSecondaryColor);
  ValueNotifier<Color> tertiaryColor =
      ValueNotifier(AppColors().initialTertiaryColor);
  ValueNotifier<String> image64String =
      ValueNotifier('assets/images/show_up_logo.png');
  ValueNotifier<TextStyle> fontTextStyle = ValueNotifier(
    const TextStyle(fontSize: 50, fontFamily: 'Roboto_regular'),
  );

  ValueNotifier<int> currentTemplate = ValueNotifier(1);
  ValueNotifier<bool> isVisible = ValueNotifier(false);
  ValueNotifier<String?> exportFeedBackDescription = ValueNotifier(null);

  void resetToInitialSettings() {
    setTemplate(newTemplate: 1);
    setPrimaryColor(newPrimaryColor: AppColors().initialPrimaryColor);
    setSecondaryColor(newSecondaryColor: AppColors().initialSecondaryColor);
    setTertiaryColor(newTertiaryColor: AppColors().initialTertiaryColor);
    setImageFile(newImageFile: 'assets/images/show_up_logo.png');
    setFontTextStyle(
      newFontTextStyle:
          const TextStyle(fontSize: 50, fontFamily: 'Roboto_regular'),
    );
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
    required String textDescriptionColor,
  }) {
    return AlertDialog(
      title: Text(textDescriptionColor),
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

  void setFontTextStyle({required TextStyle newFontTextStyle}) {
    if (fontTextStyle.value == newFontTextStyle) {
      return;
    } else {
      fontTextStyle.value = newFontTextStyle;
    }
  }

  Widget fontPicker() {
    return AlertDialog(
      content: SingleChildScrollView(
        child: SizedBox(
          width: double.maxFinite,
          child: FontPicker(
            showFontInfo: false,
            showFontVariants: false,
            showInDialog: true,
            onFontChanged: (font) => setFontTextStyle(
              newFontTextStyle: font.toTextStyle(),
            ),
            googleFonts: _appFonts.googleFonts,
          ),
        ),
      ),
    );
  }

  void setImageFile({required String newImageFile}) {
    if (image64String.value == newImageFile) {
      return;
    } else {
      image64String.value = newImageFile;
    }
  }

  void pickAndConvertImage() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*'; // Aceita somente imagens
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      if (files!.isEmpty) return;

      final reader = html.FileReader();
      reader.readAsDataUrl(files[0]);
      reader.onLoadEnd.listen((e) {
        setImageFile(newImageFile: reader.result.toString().split(',')[1]);
      });
    });
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

  Future<void> postPageInformation({
    required PageInformationModel pageInformation,
  }) async {
    try {
      await _appService.postPageInformation(
        pageInformation: pageInformation,
      );

      setExportFeedbackDescription(
          newExportFeedBackDescription: 'Exportation success!');

      resetToInitialSettings();
    } catch (e) {
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

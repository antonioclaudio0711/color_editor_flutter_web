import 'package:color_editor_flutter/shared/app_colors.dart';
import 'package:color_editor_flutter/shared/models/color_model.dart';
import 'package:color_editor_flutter/shared/models/page_information_model.dart';
import 'package:flutter/material.dart';

abstract class AppState {}

class InitialAppState extends AppState {
  InitialAppState();

  ValueNotifier<bool> isVisible = ValueNotifier(false);
  ValueNotifier<String?> feedBackDescription = ValueNotifier(null);
  ValueNotifier<PageInformationModel> pageInformation = ValueNotifier(
    PageInformationModel(
      templateNumber: 1,
      primaryColor: ColorModel(
        redIndex: AppColors().initialPrimaryColor.red,
        greenIndex: AppColors().initialPrimaryColor.green,
        blueIndex: AppColors().initialPrimaryColor.blue,
        alphaIndex: AppColors().initialPrimaryColor.alpha,
      ),
      secondaryColor: ColorModel(
        redIndex: AppColors().initialSecondaryColor.red,
        greenIndex: AppColors().initialSecondaryColor.green,
        blueIndex: AppColors().initialSecondaryColor.blue,
        alphaIndex: AppColors().initialSecondaryColor.alpha,
      ),
      tertiaryColor: ColorModel(
        redIndex: AppColors().initialTertiaryColor.red,
        greenIndex: AppColors().initialTertiaryColor.green,
        blueIndex: AppColors().initialTertiaryColor.blue,
        alphaIndex: AppColors().initialTertiaryColor.alpha,
      ),
      imageFilePath: 'assets/images/show_up_logo.png',
    ),
  );
}

class SuccessAppState extends AppState {
  SuccessAppState(
      {required this.pageInformation,
      required this.isVisible,
      required this.feedBackDescription});

  final bool isVisible;
  final String feedBackDescription;
  final PageInformationModel pageInformation;
}

class ErrorAppState extends AppState {
  ErrorAppState();
}

class LoadingAppState extends AppState {
  LoadingAppState();
}

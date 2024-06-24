import 'package:color_editor_flutter/shared/app_colors.dart';
import 'package:color_editor_flutter/shared/store/app_store.dart';
import 'package:flutter/material.dart';

class FeedbackContainer extends StatelessWidget {
  const FeedbackContainer({super.key, required this.appStore});

  final AppStore appStore;

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = AppColors();

    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color:
            appStore.exportFeedBackDescription.value == 'Exportation success!'
                ? appColors.successInformationExportColor
                : appColors.errorInformationExportColor,
        borderRadius: BorderRadius.circular(30),
      ),
      width: double.maxFinite,
      child: Text(
        appStore.exportFeedBackDescription.value!,
        textAlign: TextAlign.center,
        style: TextStyle(color: appColors.whiteForegroundColor),
      ),
    );
  }
}

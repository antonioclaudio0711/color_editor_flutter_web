import 'dart:convert';

import 'package:color_editor_flutter/shared/app_urls.dart';
import 'package:color_editor_flutter/shared/models/page_information_model.dart';
import 'package:http/http.dart' as http;

class AppService {
  AppService();

  final AppUrls appUrls = AppUrls();

  Future<void> postPageInformation(
      {required PageInformationModel pageInformation}) async {
    final url = Uri.parse(appUrls.serverUrl);

    await http.post(
      url,
      body: jsonEncode(
        {
          'templateNumber': pageInformation.templateNumber,
          'primaryColor': {
            'red': pageInformation.primaryColor.redIndex,
            'green': pageInformation.primaryColor.greenIndex,
            'blue': pageInformation.primaryColor.blueIndex,
            'alpha': pageInformation.primaryColor.alphaIndex,
          },
          'secondaryColor': {
            'red': pageInformation.secondaryColor.redIndex,
            'green': pageInformation.secondaryColor.greenIndex,
            'blue': pageInformation.secondaryColor.blueIndex,
            'alpha': pageInformation.secondaryColor.alphaIndex,
          },
          'tertiaryColor': {
            'red': pageInformation.tertiaryColor.redIndex,
            'green': pageInformation.tertiaryColor.greenIndex,
            'blue': pageInformation.tertiaryColor.blueIndex,
            'alpha': pageInformation.tertiaryColor.alphaIndex,
          },
          'imageFilePath': pageInformation.imageFilePath
        },
      ),
    );
  }
}

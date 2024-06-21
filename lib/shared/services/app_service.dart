import 'dart:convert';

import 'package:color_editor_flutter/shared/app_urls.dart';
import 'package:color_editor_flutter/shared/models/page_informations_model.dart';
import 'package:http/http.dart' as http;

class AppService {
  AppService();

  final AppUrls appUrls = AppUrls();

  Future<int> postPageInformations(
      {required PageInformationsModel pageInformations}) async {
    final url = Uri.parse(appUrls.serverUrl);

    try {
      final response = await http.post(
        url,
        body: jsonEncode(
          {
            'templateNumber': pageInformations.templateNumber,
            'primaryColor': pageInformations.primaryColor.toString(),
            'secondaryColor': pageInformations.secondaryColor.toString(),
            'tertiaryColor': pageInformations.tertiaryColor.toString(),
            'imageFilePath': pageInformations.imageFilePath
          },
        ),
      );

      return response.statusCode;
    } catch (e) {
      return e.hashCode;
    }
  }
}

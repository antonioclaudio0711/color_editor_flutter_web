import 'dart:convert';

import 'package:color_editor_flutter/shared/models/color_model.dart';

class PageInformationModel {
  PageInformationModel({
    required this.templateNumber,
    required this.primaryColor,
    required this.secondaryColor,
    required this.tertiaryColor,
    required this.imageFilePath,
    required this.fontStyleFamilyString,
  });

  final int templateNumber;
  final ColorModel primaryColor;
  final ColorModel secondaryColor;
  final ColorModel tertiaryColor;
  final String imageFilePath;
  final String fontStyleFamilyString;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'templateNumber': templateNumber,
      'primaryColor': {
        'red': primaryColor.redIndex,
        'green': primaryColor.greenIndex,
        'blue': primaryColor.blueIndex,
        'alpha': primaryColor.alphaIndex,
      },
      'secondaryColor': {
        'red': secondaryColor.redIndex,
        'green': secondaryColor.greenIndex,
        'blue': secondaryColor.blueIndex,
        'alpha': secondaryColor.alphaIndex,
      },
      'tertiaryColor': {
        'red': tertiaryColor.redIndex,
        'green': tertiaryColor.greenIndex,
        'blue': tertiaryColor.blueIndex,
        'alpha': tertiaryColor.alphaIndex,
      },
      'fontStyleFamilyString': fontStyleFamilyString,
      'imageFilePath': imageFilePath,
    };
  }

  factory PageInformationModel.fromMap(Map<String, dynamic> map) {
    return PageInformationModel(
      templateNumber: map['templateNumber'] as int,
      primaryColor: ColorModel(
        redIndex: map['primaryColor']['red'],
        greenIndex: map['primaryColor']['green'],
        blueIndex: map['primaryColor']['blue'],
        alphaIndex: map['primaryColor']['alpha'],
      ),
      secondaryColor: ColorModel(
        redIndex: map['secondaryColor']['red'],
        greenIndex: map['secondaryColor']['green'],
        blueIndex: map['secondaryColor']['blue'],
        alphaIndex: map['secondaryColor']['alpha'],
      ),
      tertiaryColor: ColorModel(
        redIndex: map['tertiaryColor']['red'],
        greenIndex: map['tertiaryColor']['green'],
        blueIndex: map['tertiaryColor']['blue'],
        alphaIndex: map['tertiaryColor']['alpha'],
      ),
      fontStyleFamilyString: map['fontStyleFamilyString'] as String,
      imageFilePath: map['imageFilePath'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PageInformationModel.fromJson(String source) =>
      PageInformationModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}

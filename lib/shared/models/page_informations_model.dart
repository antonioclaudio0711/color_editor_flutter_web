import 'dart:convert';

import 'package:flutter/material.dart';

class PageInformationsModel {
  PageInformationsModel({
    required this.templateNumber,
    required this.primaryColor,
    required this.secondaryColor,
    required this.tertiaryColor,
    required this.imageFilePath,
  });

  final int templateNumber;
  final Color primaryColor;
  final Color secondaryColor;
  final Color tertiaryColor;
  final String imageFilePath;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'templateNumber': templateNumber,
      'primaryColor': primaryColor,
      'secondaryColor': secondaryColor,
      'tertiaryColor': tertiaryColor,
      'imageFilePath': imageFilePath,
    };
  }

  factory PageInformationsModel.fromMap(Map<String, dynamic> map) {
    return PageInformationsModel(
      templateNumber: map['templateNumber'] as int,
      primaryColor: map['primaryColor'] as Color,
      secondaryColor: map['secondaryColor'] as Color,
      tertiaryColor: map['tertiaryColor'] as Color,
      imageFilePath: map['imageFilePath'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PageInformationsModel.fromJson(String source) =>
      PageInformationsModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}

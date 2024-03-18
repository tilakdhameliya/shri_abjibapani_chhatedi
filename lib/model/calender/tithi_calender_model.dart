import 'package:flutter/material.dart';

class TithiCalender {
  HeaderLines? headerLines;

  TithiCalender({this.headerLines});

  TithiCalender.fromJson(Map<String, dynamic> json) {
    headerLines = json['HeaderLines'] != null
        ? HeaderLines.fromJson(json['HeaderLines'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (headerLines != null) {
      data['HeaderLines'] = headerLines!.toJson();
    }
    return data;
  }
}

class HeaderLines {
  List<HeaderLine>? headerLine;

  HeaderLines({this.headerLine});

  HeaderLines.fromJson(Map<String, dynamic> json) {
    if (json['HeaderLine'] != null) {
      headerLine = <HeaderLine>[];
      json['HeaderLine'].forEach((v) {
        headerLine!.add(HeaderLine.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (headerLine != null) {
      data['HeaderLine'] = headerLine!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HeaderLine {
  String? date;
  String? tithi;
  List<String>? subTithi;
  String? year;
  String? suvichar;

  HeaderLine({this.date, this.tithi, this.subTithi, this.year, this.suvichar});

  HeaderLine.fromJson(Map<String, dynamic> json) {
    date = json['Date'];
    tithi = json['Tithi'];
    subTithi = json['SubTithi'].cast<String>();
    year = json['Year'];
    suvichar = json['Suvichar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Date'] = date;
    data['Tithi'] = tithi;
    data['SubTithi'] = subTithi;
    data['Year'] = year;
    data['Suvichar'] = suvichar;
    return data;
  }
}

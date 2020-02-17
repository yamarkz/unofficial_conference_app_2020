import 'package:flutter/material.dart';

class Sponsor {
  final String id;
  final String plan;
  final String planDetail;
  final String companyUrl;
  final String companyName;
  final String companyLogoUrl;
  final bool hasBooth;
  final int sort;

  const Sponsor({
    @required this.id,
    @required this.plan,
    @required this.planDetail,
    @required this.companyUrl,
    @required this.companyName,
    @required this.companyLogoUrl,
    @required this.hasBooth,
    @required this.sort,
  });

  factory Sponsor.fromJson(dynamic json) {
    return Sponsor(
      id: json['id'],
      plan: json['plan'],
      planDetail: json['planDetail'],
      companyUrl: json['companyUrl'],
      companyName: json['companyName']['ja'],
      companyLogoUrl: json['companyLogoUrl'],
      hasBooth: json['hasBooth'],
      sort: json['sort'],
    );
  }
}

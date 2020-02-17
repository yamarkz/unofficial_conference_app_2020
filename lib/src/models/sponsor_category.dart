import 'package:flutter/material.dart';
import 'package:unofficial_conference_app_2020/src/models/enums/sponsor_category_type.dart';
import 'package:unofficial_conference_app_2020/src/models/sponsor.dart';

class SponsorCategory {
  final SponsorCategoryType categoryType;
  final List<Sponsor> sponsors;

  const SponsorCategory({
    @required this.categoryType,
    @required this.sponsors,
  });
}

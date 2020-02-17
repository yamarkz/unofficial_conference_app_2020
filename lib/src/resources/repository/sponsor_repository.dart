import "package:collection/collection.dart";
import 'package:unofficial_conference_app_2020/src/models/enums/sponsor_category_type.dart';
import 'package:unofficial_conference_app_2020/src/models/sponsor.dart';
import 'package:unofficial_conference_app_2020/src/models/sponsor_category.dart';
import 'package:unofficial_conference_app_2020/src/resources/api/sponsor_api.dart';

class SponsorRepository {
  static SponsorRepository _shared;
  static SponsorRepository get shared => _shared;
  factory SponsorRepository() => _shared ??= SponsorRepository._();
  SponsorRepository._();

  final sponsorCategories = <SponsorCategory>[];

  Future<List<SponsorCategory>> getSponsorCategories() async {
    if (sponsorCategories.length > 0) return sponsorCategories;
    try {
      final response = await SponsorsApi().execute();
      response.sponsors.sort(
        (dynamic a, dynamic b) => a['sort'].compareTo(b['sort']),
      );

      final groupMap = groupBy<dynamic, dynamic>(
        response.sponsors,
        (dynamic obj) => obj['plan'],
      );

      groupMap.forEach((dynamic k, dynamic v) {
        final sponsors = <Sponsor>[];
        sponsors.addAll(v.map<Sponsor>((dynamic sponsor) {
          return Sponsor.fromJson(sponsor as dynamic);
        }).toList());

        sponsorCategories.add(
          SponsorCategory(
            categoryType: SponsorCategoryType.from(k),
            sponsors: sponsors,
          ),
        );
      });

      return sponsorCategories;
    } on Exception catch (error) {
      print(error);
      return sponsorCategories;
    }
  }
}

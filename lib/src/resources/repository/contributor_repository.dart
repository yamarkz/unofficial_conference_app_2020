import 'package:unofficial_conference_app_2020/src/models/contributor.dart';
import 'package:unofficial_conference_app_2020/src/resources/api/contributor_api.dart';

class ContributorRepository {
  static ContributorRepository _shared;
  static ContributorRepository get shared => _shared;
  factory ContributorRepository() => _shared ??= ContributorRepository._();
  ContributorRepository._();

  final contributors = <Contributor>[];

  Future<List<Contributor>> getContributors() async {
    if (contributors.length > 0) return contributors;
    try {
      final response = await ContributorsApi().execute();
      contributors.addAll(response.contributors.map((dynamic contributor) {
        return Contributor.fromJson(contributor);
      }).toList());
      return contributors;
    } on Exception catch (error) {
      print(error);
      return contributors;
    }
  }
}

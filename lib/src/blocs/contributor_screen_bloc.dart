import 'package:rxdart/rxdart.dart';
import 'package:unofficial_conference_app_2020/src/models/contributor.dart';
import 'package:unofficial_conference_app_2020/src/resources/repository/contributor_repository.dart';
import 'package:unofficial_conference_app_2020/src/utility/tuple.dart';

class ContributorScreenBloc {
  ContributorScreenBloc() {
    _load();
  }

  void dispose() {
    _contributorsSubject.close();
  }

  final _contributorsSubject =
      PublishSubject<Tuple2<List<Contributor>, bool>>();
  Observable<Tuple2<List<Contributor>, bool>> get contributorsStream =>
      _contributorsSubject.stream;

  final _contributors = <Contributor>[];
  bool _isLoading = false;

  Tuple2<List<Contributor>, bool> get contributorsValue =>
      Tuple2(_contributors, _isLoading);

  void _load() async {
    _isLoading = true;
    try {
      final contributors = await ContributorRepository().getContributors();
      _contributors.addAll(contributors);
      _isLoading = false;
      _contributorsSubject.sink.add(contributorsValue);
    } on Exception catch (e) {
      print(e);
      // todo: error handling
      _isLoading = false;
    }
  }
}

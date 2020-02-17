import 'package:rxdart/rxdart.dart';
import 'package:unofficial_conference_app_2020/src/models/sponsor_category.dart';
import 'package:unofficial_conference_app_2020/src/resources/repository/sponsor_repository.dart';
import 'package:unofficial_conference_app_2020/src/utility/tuple.dart';

class SponsorScreenBloc {
  SponsorScreenBloc() {
    _load();
  }

  void dispose() {
    _sponsorCategoriesSubject.close();
  }

  final _sponsorCategoriesSubject =
      PublishSubject<Tuple2<List<SponsorCategory>, bool>>();
  Observable<Tuple2<List<SponsorCategory>, bool>> get sponsorCategoriesStream =>
      _sponsorCategoriesSubject.stream;

  final _sponsorCategories = <SponsorCategory>[];
  bool _isLoading = false;

  Tuple2<List<SponsorCategory>, bool> get sponsorCategoriesValue =>
      Tuple2(_sponsorCategories, _isLoading);

  void _load() async {
    _isLoading = true;
    try {
      final sponsorCategories =
          await SponsorRepository().getSponsorCategories();
      _sponsorCategories.addAll(sponsorCategories);
      _isLoading = false;
      _sponsorCategoriesSubject.sink.add(sponsorCategoriesValue);
    } on Exception catch (e) {
      print(e);
      // todo: error handling
      _isLoading = false;
    }
  }
}

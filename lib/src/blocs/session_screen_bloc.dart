import 'package:unofficial_conference_app_2020/src/blocs/session_base_bloc.dart';
import 'package:unofficial_conference_app_2020/src/models/session.dart';

class SessionScreenBloc extends SessionBaseBloc {
  final Session session;

  SessionScreenBloc({this.session}) : super(session: session);
}

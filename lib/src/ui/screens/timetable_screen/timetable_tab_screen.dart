import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unofficial_conference_app_2020/src/blocs/session_item_bloc.dart';
import 'package:unofficial_conference_app_2020/src/blocs/timetable_tab_screen_bloc.dart';
import 'package:unofficial_conference_app_2020/src/models/session.dart';
import 'package:unofficial_conference_app_2020/src/ui/common/session_card_item.dart';
import 'package:unofficial_conference_app_2020/src/utility/tuple.dart';

class TimetableTabScreen extends StatefulWidget {
  @override
  _TimetableTabScreenState createState() => _TimetableTabScreenState();
}

class _TimetableTabScreenState extends State<TimetableTabScreen>
    with AutomaticKeepAliveClientMixin<TimetableTabScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final bloc = Provider.of<TimetableTabScreenBloc>(context);
    return StreamBuilder<Tuple2<List<Session>, bool>>(
      stream: bloc.sessionsStream,
      initialData: bloc.sessionsValue,
      builder: (_, snapshot) {
        final sessions = <Session>[];
        var isLoading = true;
        if (snapshot.hasData) {
          sessions.addAll(snapshot.data.value1);
          isLoading = snapshot.data.value2;
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error'));
        } else if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (sessions.length == 0) {
          return buildBlankListView();
        } else {
          return ListView.builder(
            //physics: const BouncingScrollPhysics(),
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: sessions.length,
            itemBuilder: (BuildContext context, int index) {
              return buildSessionItem(sessions[index]);
            },
          );
        }
      },
    );
  }

  Widget buildSessionItem(Session session) {
    return Provider<SessionItemBloc>(
      create: (_) => SessionItemBloc(session: session),
      dispose: (_, bloc) => bloc.dispose(),
      child: SessionCardItem(session: session),
    );
  }

  Widget buildBlankListView() {
    return Container();
  }
}

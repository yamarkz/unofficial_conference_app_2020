import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unofficial_conference_app_2020/src/blocs/search_screen/search_session_screen_bloc.dart';
import 'package:unofficial_conference_app_2020/src/blocs/session_item_bloc.dart';
import 'package:unofficial_conference_app_2020/src/models/session.dart';
import 'package:unofficial_conference_app_2020/src/ui/common/session_item.dart';
import 'package:unofficial_conference_app_2020/src/utility/tuple.dart';

class SearchSessionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final bloc = Provider.of<SearchSessionScreenBloc>(context);
    return Container(
      child: StreamBuilder<Tuple2<List<Session>, bool>>(
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
          } else {
            return ListView.builder(
              padding: const EdgeInsets.only(right: 20, left: 20),
              physics: const BouncingScrollPhysics(),
              itemCount: sessions.length,
              itemBuilder: (BuildContext context, int index) {
                return buildSessionItem(sessions[index]);
              },
            );
          }
        },
      ),
    );
  }

  Widget buildSessionItem(Session session) {
    return Provider<SessionItemBloc>(
      create: (_) => SessionItemBloc(session: session),
      dispose: (_, bloc) => bloc.dispose(),
      child: SessionItem(
        session: session,
        showStartHourMinute: false,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unofficial_conference_app_2020/src/blocs/session_item_bloc.dart';
import 'package:unofficial_conference_app_2020/src/blocs/timeline_screen/timeline_my_plan_screen_bloc.dart';
import 'package:unofficial_conference_app_2020/src/models/session.dart';
import 'package:unofficial_conference_app_2020/src/ui/common/removable_item.dart';
import 'package:unofficial_conference_app_2020/src/ui/common/session_item.dart';
import 'package:unofficial_conference_app_2020/src/ui/screens/timeline_screen/timeline_screen.dart';

class TimelineMyPlanScreen extends TimelineScreen<TimelineMyPlanScreenBloc> {
  @override
  Widget buildBlankListView(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.bookmark,
            color: Theme.of(context).colorScheme.secondary,
            size: 100,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 90, right: 90),
            child: Text(
              'お気に入りのセッションを登録するとあなた専用のプランを作ることができます。',
              style: Theme.of(context)
                  .textTheme
                  .subtitle
                  .copyWith(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildSessionItem(Session session) {
    return MultiProvider(
      providers: [
        Provider<RemovableItemBloc>(
          create: (_) => RemovableItemBloc(),
          dispose: (_, bloc) => bloc.dispose(),
        ),
        Provider<SessionItemBloc>(
          create: (_) => SessionItemBloc(session: session),
          dispose: (_, bloc) => bloc.dispose(),
        ),
      ],
      child: RemovableItem(
        key: Key(session.id),
        child: SessionItem(session: session, removable: true),
      ),
    );
  }
}

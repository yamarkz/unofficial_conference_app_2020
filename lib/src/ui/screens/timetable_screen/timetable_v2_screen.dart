import 'package:flutter/material.dart';
import 'package:flutter_timetable_view/flutter_timetable_view.dart';
import 'package:provider/provider.dart';
import 'package:unofficial_conference_app_2020/src/blocs/theme_bloc.dart';
import 'package:unofficial_conference_app_2020/src/blocs/timetable_v2_bloc.dart';
import 'package:unofficial_conference_app_2020/src/models/room.dart';
import 'package:unofficial_conference_app_2020/src/models/session.dart';
import 'package:unofficial_conference_app_2020/src/models/session_contents.dart';
import 'package:unofficial_conference_app_2020/src/ui/routes/router.dart';
import 'package:unofficial_conference_app_2020/src/utility/droid_kaigi_theme.dart';
import 'package:unofficial_conference_app_2020/src/utility/tuple.dart';

class TimetableV2Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Timetable V2',
          style: Theme.of(context)
              .textTheme
              .title
              .copyWith(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final bloc = Provider.of<TimetableV2Bloc>(context);
    return StreamBuilder<Tuple2<SessionContents, bool>>(
      stream: bloc.sessionContentsStream,
      initialData: bloc.sessionContentsValue,
      builder: (_, snapshot) {
        var isLoading = true;
        SessionContents sessionContents;
        if (snapshot.hasData) {
          sessionContents = snapshot.data.value1;
          isLoading = snapshot.data.value2;
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error'));
        } else if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (sessionContents == null) {
          return Container();
        } else {
          return SafeArea(
            child: TimetableView(
              laneEventsList: _buildLaneEventsList(context, sessionContents),
              timetableStyle: TimetableStyle(
                startHour: 9,
                endHour: 21,
                mainBackgroundColor: Theme.of(context).colorScheme.background,
                timelineItemColor: Theme.of(context).colorScheme.background,
                cornerColor: Theme.of(context).colorScheme.background,
                laneColor: Theme.of(context).backgroundColor,
                timeItemTextColor: Theme.of(context).colorScheme.onBackground,
                timelineBorderColor: Theme.of(context).colorScheme.onBackground,
                timeItemHeight: 180,
                laneHeight: 60,
              ),
            ),
          );
        }
      },
    );
  }

  List<LaneEvents> _buildLaneEventsList(
    BuildContext context,
    SessionContents sessionContents,
  ) {
    final bloc = Provider.of<ThemeBloc>(context);
    final laneEvents = <LaneEvents>[];
    sessionContents.rooms.forEach((Room room) {
      final sessions = sessionContents.sessions.where((session) {
        return session.roomId == room.id && session.dayNumber == 1;
      });

      final tableEvents = sessions.map((Session session) {
        return TableEvent(
          title: session.title,
          backgroundColor: bloc.isDark
              ? DroidKaigiColors.lightBlue300
              : Colors.lightBlue[100],
          textStyle: Theme.of(context).textTheme.body2.copyWith(
                color: bloc.isDark
                    ? Theme.of(context).colorScheme.onBackground
                    : Theme.of(context).colorScheme.primary,
              ),
          start: TableEventTime(
            hour: session.startsAt.hour,
            minute: session.startsAt.minute,
          ),
          end: TableEventTime(
            hour: session.endsAt.hour,
            minute: session.endsAt.minute,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(RouteName.session, arguments: {
              RouteParam.session: session,
            });
          },
        );
      }).toList();

      laneEvents.add(
        LaneEvents(
          lane: Lane(
            name: room.name,
            backgroundColor: Theme.of(context).colorScheme.background,
            textStyle: Theme.of(context).textTheme.subtitle,
          ),
          events: tableEvents,
        ),
      );
    });

    return laneEvents;
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unofficial_conference_app_2020/src/blocs/speaker_screen_bloc.dart';
import 'package:unofficial_conference_app_2020/src/blocs/theme_bloc.dart';
import 'package:unofficial_conference_app_2020/src/l10n/strings.dart';
import 'package:unofficial_conference_app_2020/src/models/session.dart';
import 'package:unofficial_conference_app_2020/src/models/speaker.dart';
import 'package:unofficial_conference_app_2020/src/ui/common/avator_icon.dart';
import 'package:unofficial_conference_app_2020/src/ui/routes/router.dart';
import 'package:unofficial_conference_app_2020/src/utility/tuple.dart';

class SpeakerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Theme.of(context).colorScheme.onBackground,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      elevation: 0,
    );
  }

  Widget _buildBody(BuildContext context) {
    final bloc = Provider.of<SpeakerScreenBloc>(context);
    return StreamBuilder<Tuple2<Speaker, bool>>(
      stream: bloc.speakerStream,
      initialData: bloc.speakerValue,
      builder: (_, snapshot) {
        Speaker speaker;
        var isLoading = true;
        if (snapshot.hasData) {
          speaker = snapshot.data.value1;
          isLoading = snapshot.data.value2;
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error'));
        } else if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return _buildContent(context, speaker);
        }
      },
    );
  }

  Widget _buildContent(BuildContext context, Speaker speaker) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: <Widget>[
          Container(
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    child: AvatarIcon(
                      imageUrl: speaker.imageUrl,
                      radius: 50,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    speaker.name,
                    style: Theme.of(context).textTheme.headline,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    speaker.tagLine,
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            thickness: 1,
            height: 40,
          ),
          Center(
            child: Text(
              speaker.bio,
              style: Theme.of(context).textTheme.body1,
            ),
          ),
          const Divider(
            thickness: 1,
            height: 40,
          ),
          Text(
            Strings.of(context).timeline,
            style: Theme.of(context)
                .textTheme
                .body1
                .copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          _buildSpeakerSession(context),
        ],
      ),
    );
  }

  Widget _buildSpeakerSession(BuildContext context) {
    final bloc = Provider.of<SpeakerScreenBloc>(context);
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
        } else {
          return _buildSpeakerSessionContent(context, sessions);
        }
      },
    );
  }

  Widget _buildSpeakerSessionContent(
    BuildContext context,
    List<Session> sessions,
  ) {
    final bloc = Provider.of<ThemeBloc>(context);
    return Column(
      children: sessions.map((session) {
        return Container(
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(RouteName.session, arguments: {
                RouteParam.session: session,
              });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 4),
                Text(
                  session.title,
                  style: Theme.of(context).textTheme.body1,
                ),
                const SizedBox(height: 4),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: bloc.isDark
                          ? Theme.of(context).colorScheme.onBackground
                          : Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      session.sessionTimeSpan(),
                      style: Theme.of(context).textTheme.body2.copyWith(
                            color: bloc.isDark
                                ? Theme.of(context).colorScheme.onBackground
                                : Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

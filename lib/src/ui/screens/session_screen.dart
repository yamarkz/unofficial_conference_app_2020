import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unofficial_conference_app_2020/src/blocs/session_screen_bloc.dart';
import 'package:unofficial_conference_app_2020/src/blocs/theme_bloc.dart';
import 'package:unofficial_conference_app_2020/src/l10n/strings.dart';
import 'package:unofficial_conference_app_2020/src/models/session.dart';
import 'package:unofficial_conference_app_2020/src/ui/common/avator_icon.dart';
import 'package:unofficial_conference_app_2020/src/ui/common/favorite_button/favorite_button.dart';
import 'package:unofficial_conference_app_2020/src/ui/common/read_more_text.dart';
import 'package:unofficial_conference_app_2020/src/ui/routes/router.dart';
import 'package:unofficial_conference_app_2020/src/utility/droid_kaigi_theme.dart';

class SessionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      floatingActionButton: _buildFloatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: _buildBottomAppBar(context),
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
    final bloc = Provider.of<SessionScreenBloc>(context);
    return _buildContent(context, bloc.session);
  }

  Widget _buildContent(BuildContext context, Session session) {
    final bloc = Provider.of<ThemeBloc>(context);
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: ListView(
        children: <Widget>[
          Text(
            session.title,
            style: Theme.of(context).textTheme.headline.copyWith(
                fontSize: 28,
                color: (bloc.isDark
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.primary)),
          ),
          const SizedBox(height: 4),
          Row(
            children: <Widget>[
              Icon(
                Icons.access_time,
                size: 14,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              const SizedBox(width: 5),
              Text(
                session.sessionTimeSpan(),
                style: Theme.of(context).textTheme.subtitle,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '${session.sessionScale()} / ${session.room.name}',
            style: Theme.of(context).textTheme.caption,
          ),
          const SizedBox(height: 32),
          Row(children: _buildSessionLabels(context, session)),
          const SizedBox(height: 8),
          const Divider(
            thickness: 1,
            height: 40,
          ),
          Center(
            child: ReadMoreText(
              (session.description == null ? '' : session.description),
              trimLines: 6,
              colorClickableText: DroidKaigiColors.lightBlue300,
              trimMode: TrimMode.line,
              trimCollapsedText: ' ${Strings.of(context).readMore}',
              trimExpandedText: '',
              style: Theme.of(context).textTheme.body1,
            ),
          ),
          const Divider(
            thickness: 1,
            height: 40,
          ),
          Text(
            Strings.of(context).targetAudience,
            style: Theme.of(context).textTheme.body1.copyWith(
                  fontWeight: FontWeight.w600,
                  color: bloc.isDark
                      ? Theme.of(context).colorScheme.onBackground
                      : Theme.of(context).colorScheme.primary,
                ),
          ),
          const SizedBox(height: 18),
          Text(
            session.targetAudience,
            style: Theme.of(context).textTheme.body1,
          ),
          const Divider(
            thickness: 1,
            height: 40,
          ),
          Text(
            Strings.of(context).speaker,
            style: Theme.of(context).textTheme.body1.copyWith(
                  fontWeight: FontWeight.w600,
                  color: bloc.isDark
                      ? Theme.of(context).colorScheme.onBackground
                      : Theme.of(context).colorScheme.primary,
                ),
          ),
          const SizedBox(height: 12),
          Column(children: _buildSpeakers(context, session)),
          const SizedBox(height: 12),
          const Divider(
            thickness: 1,
            height: 40,
          ),
          Text(
            Strings.of(context).document,
            style: Theme.of(context).textTheme.body1.copyWith(
                  fontWeight: FontWeight.w600,
                  color: bloc.isDark
                      ? Theme.of(context).colorScheme.onBackground
                      : Theme.of(context).colorScheme.primary,
                ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    print('click: movie');
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.videocam,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        Strings.of(context).movie,
                        style: Theme.of(context).textTheme.body1.copyWith(
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                InkWell(
                  onTap: () {
                    print('click: slide');
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.photo_library,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        Strings.of(context).slide,
                        style: Theme.of(context).textTheme.body1.copyWith(
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 60),
              ],
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildSessionLabels(BuildContext context, Session session) {
    final bloc = Provider.of<ThemeBloc>(context);
    return [
      Container(
        decoration: BoxDecoration(
          color: bloc.isDark
              ? DroidKaigiColors.indigo900
              : DroidKaigiColors.indigo100,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(7),
          child: Text(
            session.category.name,
            style: Theme.of(context).textTheme.body2.copyWith(
                  color: bloc.isDark
                      ? Theme.of(context).colorScheme.onBackground
                      : Theme.of(context).colorScheme.primary,
                ),
          ),
        ),
      ),
      const SizedBox(width: 10),
      Container(
        decoration: BoxDecoration(
          color: bloc.isDark
              ? DroidKaigiColors.lightBlue300
              : Colors.lightBlue[100],
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(7),
          child: Text(
            session.language.rawValue,
            style: Theme.of(context).textTheme.body2.copyWith(
                  color: bloc.isDark
                      ? Theme.of(context).colorScheme.onBackground
                      : Theme.of(context).colorScheme.primary,
                ),
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildSpeakers(BuildContext context, Session session) {
    return session.speakers.map((speaker) {
      return Container(
        margin: const EdgeInsets.only(top: 5, bottom: 5),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(RouteName.speaker, arguments: {
              RouteParam.speaker: speaker,
            });
          },
          child: Row(
            children: <Widget>[
              AvatarIcon(
                imageUrl: speaker.imageUrl,
                radius: 30,
              ),
              const SizedBox(width: 16),
              Text(
                speaker.name,
                style: TextStyle(
                  fontSize: 16,
                  color: DroidKaigiColors.lightBlue300,
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    final bloc = Provider.of<SessionScreenBloc>(context);
    return StreamBuilder<bool>(
      stream: bloc.changeFavoriteStream,
      initialData: bloc.isFavorite,
      builder: (_, snapshot) {
        // work onTap and onPressed
        return FloatingActionButton(
          elevation: 12,
          backgroundColor: Theme.of(context).cardColor,
          child: FavoriteButton(
            isFavorite: snapshot.data,
            size: 25,
            onTap: () {
              bloc.favorite();
            },
          ),
          onPressed: () {
            bloc.favorite();
          },
        );
      },
    );
  }

  Widget _buildBottomAppBar(BuildContext context) {
    return BottomAppBar(
      clipBehavior: Clip.antiAlias,
      shape: const CircularNotchedRectangle(),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.share),
            color: Theme.of(context).colorScheme.onPrimary,
            onPressed: () {
              print('click');
            },
          ),
          IconButton(
            icon: const Icon(Icons.location_on),
            color: Theme.of(context).colorScheme.onPrimary,
            onPressed: () {
              Navigator.of(context).pushNamed(RouteName.floorMap);
            },
          ),
        ],
      ),
    );
  }
}

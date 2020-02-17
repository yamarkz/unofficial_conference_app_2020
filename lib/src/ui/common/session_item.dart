import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unofficial_conference_app_2020/src/blocs/session_item_bloc.dart';
import 'package:unofficial_conference_app_2020/src/blocs/theme_bloc.dart';
import 'package:unofficial_conference_app_2020/src/models/session.dart';
import 'package:unofficial_conference_app_2020/src/ui/common/avator_icon.dart';
import 'package:unofficial_conference_app_2020/src/ui/common/favorite_button/favorite_button.dart';
import 'package:unofficial_conference_app_2020/src/ui/common/removable_item.dart';
import 'package:unofficial_conference_app_2020/src/ui/routes/router.dart';
import 'package:unofficial_conference_app_2020/src/utility/droid_kaigi_theme.dart';

class SessionItem extends StatelessWidget {
  final Session session;
  final bool removable;
  final bool showStartHourMinute;

  SessionItem({
    @required this.session,
    this.removable = false,
    this.showStartHourMinute = true,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<ThemeBloc>(context);
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
      ),
      margin: const EdgeInsets.all(0),
      elevation: 0,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(RouteName.session, arguments: {
            RouteParam.session: session,
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              (showStartHourMinute
                  ? Expanded(
                      flex: 2,
                      child: Text(
                        session.startHourMinute(),
                        style: Theme.of(context).textTheme.body1.copyWith(
                            color: bloc.isDark
                                ? DroidKaigiColors.white
                                : DroidKaigiColors.blackAlpha38),
                      ),
                    )
                  : Container()),
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      session.room.name,
                      style: Theme.of(context).textTheme.caption.copyWith(
                          color: bloc.isDark
                              ? DroidKaigiColors.white
                              : DroidKaigiColors.blackAlpha38),
                    ),
                    const SizedBox(height: 10),
                    Text(session.title,
                        style: Theme.of(context)
                            .textTheme
                            .title
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: _buildSpeakers(context),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: removable
                    ? _buildRemovableFavoriteButton(context)
                    : _buildFavoriteButton(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFavoriteButton(BuildContext context) {
    final bloc = Provider.of<SessionItemBloc>(context);
    return StreamBuilder<bool>(
      stream: bloc.changeFavoriteStream,
      initialData: bloc.isFavorite,
      builder: (_, snapshot) {
        return FavoriteButton(
          isFavorite: snapshot.data,
          size: 25,
          onTap: () {
            bloc.favorite();
          },
        );
      },
    );
  }

  Widget _buildRemovableFavoriteButton(BuildContext context) {
    final bloc = Provider.of<SessionItemBloc>(context);
    final removableBloc = Provider.of<RemovableItemBloc>(context);
    return StreamBuilder<bool>(
      stream: bloc.changeFavoriteStream,
      initialData: bloc.isFavorite,
      builder: (_, snapshot) {
        return IconButton(
          onPressed: () {
            removableBloc.remove();
            Timer(const Duration(milliseconds: 1000), () async {
              await bloc.favorite();
            });
          },
          icon: Icon(
            (snapshot.data ? Icons.bookmark : Icons.bookmark_border),
            color: DroidKaigiColors.lightBlue300,
            size: 25,
          ),
        );
      },
    );
  }

  List<Widget> _buildSpeakers(BuildContext context) {
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
                radius: 12,
                size: 20,
              ),
              const SizedBox(width: 5),
              Text(
                speaker.name,
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ),
      );
    }).toList();
  }
}

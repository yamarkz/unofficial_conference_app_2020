import 'package:flutter/material.dart';
import 'package:unofficial_conference_app_2020/src/models/session.dart';
import 'package:unofficial_conference_app_2020/src/ui/common/avator_icon.dart';
import 'package:unofficial_conference_app_2020/src/ui/routes/router.dart';

class SessionCardItem extends StatelessWidget {
  final Session session;

  SessionCardItem({
    @required this.session,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Text(
                  '${session.startHourMinute()} ~ '
                  '${session.endHourMinute()}',
                  style: Theme.of(context).textTheme.title,
                ),
              ],
            ),
          ),
          Card(
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(RouteName.session, arguments: {
                  RouteParam.session: session,
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Text(
                            '${session.sessionDate()}',
                            style: Theme.of(context).textTheme.caption,
                          ),
                          Text(' / ',
                              style: Theme.of(context).textTheme.caption),
                          Text(
                            '${session.startHourMinute()} ~ '
                            '${session.endHourMinute()}',
                            style: Theme.of(context).textTheme.caption,
                          ),
                          Text(' / ',
                              style: Theme.of(context).textTheme.caption),
                          Text(
                            '${session.room.name}',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      child: Text(
                        session.title,
                        style: Theme.of(context).textTheme.title,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      child: Text(
                        (session.description == null
                            ? ''
                            : session.description),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: Theme.of(context).textTheme.body2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.star,
                            size: 18,
                            color: Theme.of(context).accentColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            session.category.name,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: _buildSpeakers(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
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

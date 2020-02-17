import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unofficial_conference_app_2020/src/blocs/session_item_bloc.dart';
import 'package:unofficial_conference_app_2020/src/blocs/theme_bloc.dart';
import 'package:unofficial_conference_app_2020/src/blocs/timeline_screen/timeline_screen_bloc.dart';
import 'package:unofficial_conference_app_2020/src/l10n/strings.dart';
import 'package:unofficial_conference_app_2020/src/models/category.dart';
import 'package:unofficial_conference_app_2020/src/models/enums/lang.dart';
import 'package:unofficial_conference_app_2020/src/models/room.dart';
import 'package:unofficial_conference_app_2020/src/models/session.dart';
import 'package:unofficial_conference_app_2020/src/ui/common/backdrop.dart';
import 'package:unofficial_conference_app_2020/src/ui/common/session_item.dart';
import 'package:unofficial_conference_app_2020/src/ui/common/tag_button.dart';
import 'package:unofficial_conference_app_2020/src/utility/droid_kaigi_theme.dart';
import 'package:unofficial_conference_app_2020/src/utility/tuple.dart';

class TimelineScreen<T> extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BackDrop(
      currentIndex: 1,
      backLayer: _buildBackLayer,
      frontLayer: _buildFrontLayer,
    );
  }

  Widget _buildBackLayer(BuildContext context) {
    final bloc = Provider.of<T>(context) as TimelineScreenBloc;
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.primary,
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Filter',
                  style: Theme.of(context)
                      .textTheme
                      .headline
                      .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                ),
                FlatButton.icon(
                  color: DroidKaigiColors.indigo500,
                  icon: Icon(
                    Icons.close,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  label: Text(
                    Strings.of(context).reset,
                    style: Theme.of(context).textTheme.subtitle.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  onPressed: () {
                    bloc.resetFilterChange();
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Room',
              style: Theme.of(context)
                  .textTheme
                  .body1
                  .copyWith(color: Theme.of(context).colorScheme.onPrimary),
            ),
            const SizedBox(height: 10),
            Container(
              child: StreamBuilder<Tuple2<List<Room>, bool>>(
                stream: bloc.roomsStream,
                initialData: bloc.roomsValue,
                builder: (_, snapshot) {
                  final rooms = <Room>[];
                  var isLoading = true;
                  if (snapshot.hasData) {
                    rooms.addAll(snapshot.data.value1);
                    isLoading = snapshot.data.value2;
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text('Error'));
                  } else if (isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return Wrap(
                      spacing: 10,
                      children: rooms.map((room) {
                        return TagButton(
                          name: room.name,
                          obj: room,
                          change: bloc.roomFilterChange,
                          resetSubject: bloc.resetSubject,
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Language',
              style: Theme.of(context)
                  .textTheme
                  .body1
                  .copyWith(color: Theme.of(context).colorScheme.onPrimary),
            ),
            const SizedBox(height: 10),
            Container(
              child: StreamBuilder<Tuple2<List<Lang>, bool>>(
                stream: bloc.langsStream,
                initialData: bloc.langsValue,
                builder: (_, snapshot) {
                  final langs = <Lang>[];
                  var isLoading = true;
                  if (snapshot.hasData) {
                    langs.addAll(snapshot.data.value1);
                    isLoading = snapshot.data.value2;
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text('Error'));
                  } else if (isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return Wrap(
                      spacing: 10,
                      children: langs.map((lang) {
                        return TagButton(
                          name: lang.rawValue,
                          obj: lang,
                          change: bloc.langFilterChange,
                          resetSubject: bloc.resetSubject,
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Category',
              style: Theme.of(context)
                  .textTheme
                  .body1
                  .copyWith(color: Theme.of(context).colorScheme.onPrimary),
            ),
            const SizedBox(height: 10),
            Container(
              child: StreamBuilder<Tuple2<List<Category>, bool>>(
                stream: bloc.categoriesStream,
                initialData: bloc.categoriesValue,
                builder: (_, snapshot) {
                  final categories = <Category>[];
                  var isLoading = true;
                  if (snapshot.hasData) {
                    categories.addAll(snapshot.data.value1);
                    isLoading = snapshot.data.value2;
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text('Error'));
                  } else if (isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return Wrap(
                      spacing: 10,
                      children: categories.map((category) {
                        return TagButton(
                          name: category.name,
                          obj: category,
                          change: bloc.categoryFilterChange,
                          resetSubject: bloc.resetSubject,
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildFrontLayer(BuildContext context, Function open) {
    final bloc = Provider.of<T>(context) as TimelineScreenBloc;
    final themeBloc = Provider.of<ThemeBloc>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20)),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  StreamBuilder<int>(
                    stream: bloc.sessionCountStream,
                    initialData: bloc.sessionCountValue,
                    builder: (_, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          '${Strings.of(context).targetSession} : '
                          '${snapshot.data}',
                          style: Theme.of(context).textTheme.subtitle,
                        );
                      } else {
                        return Text(
                          '${Strings.of(context).targetSession} : ',
                          style: Theme.of(context).textTheme.subtitle,
                        );
                      }
                    },
                  ),
                  FlatButton.icon(
                    onPressed: () {
                      open();
                    },
                    icon: Icon(
                      Icons.filter_list,
                      color: themeBloc.isDark
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.primary,
                    ),
                    label: Text(
                      Strings.of(context).filter,
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              height: 0,
            ),
            Expanded(
              child: Container(
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
                    } else if (sessions.length == 0) {
                      return buildBlankListView(context);
                    } else {
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: sessions.length,
                        itemBuilder: (BuildContext context, int index) {
                          return buildSessionItem(sessions[index]);
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSessionItem(Session session) {
    return Provider<SessionItemBloc>(
      create: (_) => SessionItemBloc(session: session),
      dispose: (_, bloc) => bloc.dispose(),
      child: SessionItem(session: session),
    );
  }

  Widget buildBlankListView(BuildContext context) {
    return Container();
  }
}

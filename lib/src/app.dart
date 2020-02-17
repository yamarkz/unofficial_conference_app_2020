import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:unofficial_conference_app_2020/src/blocs/theme_bloc.dart';
import 'package:unofficial_conference_app_2020/src/l10n/strings_delegate.dart';
import 'package:unofficial_conference_app_2020/src/ui/routes/router.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<ThemeBloc>(
      create: (context) => ThemeBloc(),
      dispose: (_, bloc) => bloc.dispose(),
      child: Material(),
    );
  }
}

class Material extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<ThemeBloc>(context);
    return StreamBuilder<ThemeMode>(
      initialData: bloc.selectTheme,
      stream: bloc.themeMode,
      builder: (context, snapshot) {
        return MaterialApp(
          title: 'DroidKaigi Unofficial App 2020',
          theme: bloc.lightTheme,
          darkTheme: bloc.darkTheme,
          themeMode: snapshot.data,
          localizationsDelegates: [
            const StringsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ja'),
            Locale('en'),
          ],
          initialRoute: RouteName.splash,
          onGenerateRoute: Router.onGenerateRoute,
        );
      },
    );
  }
}

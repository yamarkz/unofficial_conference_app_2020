import 'dart:async';

import 'package:flutter/material.dart';
import 'package:unofficial_conference_app_2020/src/blocs/auth_bloc.dart';
import 'package:unofficial_conference_app_2020/src/ui/routes/router.dart';
import 'package:unofficial_conference_app_2020/src/utility/droid_kaigi_theme.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _errorMessage;
  bool get _hasError => _errorMessage != null;

  @override
  initState() {
    super.initState();
    _start();
  }

  void _start() async {
    Timer(const Duration(milliseconds: 1000), () {
      _gotoNextScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Stack(children: [
        Container(
          alignment: Alignment.center,
          color: Colors.white,
          child: Image.asset(
            'assets/images/Logo.png',
            width: 180,
            height: 70,
          ),
        ),
        _hasError
            ? Positioned(
                bottom: mediaQuery.padding.bottom + 32,
                width: 300,
                left: (mediaQuery.size.width - 300) / 2,
                child: _buildError(context),
              )
            : Container(),
      ]),
    );
  }

  Widget _buildError(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(8, 16, 8, 12),
          decoration: BoxDecoration(
            color: DroidKaigiColors.indigo400,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          child: Text(
            _errorMessage,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SizedBox(
            height: 48,
            width: double.infinity,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: DroidKaigiColors.indigo900),
              ),
              child: const Text(
                '再読み込み',
              ),
              onPressed: () => _gotoNextScreen(),
            ),
          ),
        ),
      ],
    );
  }

  void _gotoNextScreen() async {
    try {
      final result = await AuthBloc().signIn();
      if (result) {
        Navigator.of(context).pushReplacementNamed(RouteName.main);
      } else {
        setState(() {
          _errorMessage = 'ユーザー認証に失敗しました。管理者に連絡してください';
        });
      }
    } on Exception catch (error) {
      print(error);
      setState(() {
        _errorMessage = 'ユーザー認証に失敗しました。管理者に連絡してください';
      });
    }
  }
}

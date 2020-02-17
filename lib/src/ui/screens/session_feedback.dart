import 'package:flutter/material.dart';
import 'package:unofficial_conference_app_2020/src/utility/droid_kaigi_theme.dart';

class SessionFeedbackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: const Center(
        child: Text('sessionFeedback'),
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      iconTheme: IconThemeData(
        color: DroidKaigiColors.black,
      ),
      backgroundColor: DroidKaigiColors.white,
      elevation: 0,
      title: Row(
        children: <Widget>[
          Text(
            'セッションアンケート',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: DroidKaigiColors.blackAlpha87,
            ),
          ),
        ],
      ),
    );
  }
}

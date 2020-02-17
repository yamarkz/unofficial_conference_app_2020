import 'package:flutter/material.dart';
import 'package:unofficial_conference_app_2020/src/models/sponsor.dart';
import 'package:unofficial_conference_app_2020/src/ui/routes/router.dart';

class SponsorItem extends StatelessWidget {
  final Sponsor sponsor;

  SponsorItem({
    @required this.sponsor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Card(
          elevation: 4,
          child: Center(
            child: Image.network(
              sponsor.companyLogoUrl,
              width: 300,
            ),
          ),
        ),
        Positioned.fill(
          top: 4,
          left: 4,
          right: 4,
          bottom: 4,
          child: FlatButton(
            child: Container(),
            onPressed: () {
              Navigator.of(context).pushNamed(RouteName.webview, arguments: {
                RouteParam.url: sponsor.companyUrl,
              });
            },
          ),
        ),
      ],
    );
  }
}

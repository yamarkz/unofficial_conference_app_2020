import 'package:flutter/material.dart';
import 'package:unofficial_conference_app_2020/src/models/contributor.dart';
import 'package:unofficial_conference_app_2020/src/ui/common/avator_icon.dart';
import 'package:unofficial_conference_app_2020/src/ui/routes/router.dart';

class ContributorItem extends StatelessWidget {
  final Contributor contributor;

  ContributorItem({
    @required this.contributor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(RouteName.webview, arguments: {
            RouteParam.url: contributor.profileUrl,
          });
        },
        child: Row(
          children: <Widget>[
            AvatarIcon(
              imageUrl: contributor.iconUrl,
              radius: 30,
            ),
            const SizedBox(width: 10),
            Text(
              contributor.name,
              style: Theme.of(context).textTheme.body1,
            ),
          ],
        ),
      ),
    );
  }
}

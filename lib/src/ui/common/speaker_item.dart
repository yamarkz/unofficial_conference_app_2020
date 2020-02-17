import 'package:flutter/material.dart';
import 'package:unofficial_conference_app_2020/src/models/speaker.dart';
import 'package:unofficial_conference_app_2020/src/ui/common/avator_icon.dart';

class SpeakerItem extends StatelessWidget {
  final Speaker speaker;

  SpeakerItem({
    @required this.speaker,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      child: InkWell(
        onTap: () async {},
        child: Row(
          children: <Widget>[
            AvatarIcon(
              imageUrl: speaker.imageUrl,
              radius: 30,
            ),
            const SizedBox(width: 10),
            Text(
              speaker.name,
              style: Theme.of(context).textTheme.body1,
            ),
          ],
        ),
      ),
    );
  }
}

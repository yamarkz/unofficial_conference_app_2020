import 'package:flutter/material.dart';
import 'package:unofficial_conference_app_2020/src/utility/droid_kaigi_theme.dart';

class AnnounceItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color(0xFFDCF3FA),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  child: Icon(
                    Icons.confirmation_number,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '2月20日 13:50',
                  style: TextStyle(color: DroidKaigiColors.blackAlpha38),
                ),
                const SizedBox(height: 6),
                Text(
                  'フィードバックのお願い',
                  style: Theme.of(context).textTheme.title.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  'セッションやDroidKaigi2019へのフィードバックを受け付けております。'
                  '未回答の方はご協力ください。DroidKaigi 2019 にご来場いただき、ありがとうございました。',
                  style: Theme.of(context).textTheme.subtitle.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

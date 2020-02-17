import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unofficial_conference_app_2020/src/blocs/search_screen/search_speaker_screen_bloc.dart';
import 'package:unofficial_conference_app_2020/src/models/speaker.dart';
import 'package:unofficial_conference_app_2020/src/ui/common/speaker_item.dart';
import 'package:unofficial_conference_app_2020/src/utility/tuple.dart';

class SearchSpeakerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final bloc = Provider.of<SearchSpeakerScreenBloc>(context);
    return Container(
        child: StreamBuilder<Tuple2<List<Speaker>, bool>>(
      stream: bloc.speakersStream,
      initialData: bloc.speakersValue,
      builder: (_, snapshot) {
        final speakers = <Speaker>[];
        var isLoading = true;
        if (snapshot.hasData) {
          speakers.addAll(snapshot.data.value1);
          isLoading = snapshot.data.value2;
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error'));
        } else if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            padding: const EdgeInsets.only(right: 20, left: 20),
            physics: const BouncingScrollPhysics(),
            itemCount: speakers.length,
            itemBuilder: (BuildContext context, int index) {
              return buildSpeakerItem(speakers[index]);
            },
          );
        }
      },
    ));
  }

  Widget buildSpeakerItem(Speaker speaker) {
    return SpeakerItem(speaker: speaker);
  }
}

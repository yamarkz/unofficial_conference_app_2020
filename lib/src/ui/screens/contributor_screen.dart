import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unofficial_conference_app_2020/src/blocs/contributor_screen_bloc.dart';
import 'package:unofficial_conference_app_2020/src/l10n/strings.dart';
import 'package:unofficial_conference_app_2020/src/models/contributor.dart';
import 'package:unofficial_conference_app_2020/src/ui/common/contributor_item.dart';
import 'package:unofficial_conference_app_2020/src/utility/tuple.dart';

class ContributorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Theme.of(context).colorScheme.onBackground,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      elevation: 0,
      title: Text(
        Strings.of(context).contributors,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final bloc = Provider.of<ContributorScreenBloc>(context);
    return Container(
      child: StreamBuilder<Tuple2<List<Contributor>, bool>>(
        stream: bloc.contributorsStream,
        initialData: bloc.contributorsValue,
        builder: (_, snapshot) {
          final contributors = <Contributor>[];
          var isLoading = true;
          if (snapshot.hasData) {
            contributors.addAll(snapshot.data.value1);
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
              itemCount: contributors.length,
              itemBuilder: (BuildContext context, int index) {
                return ContributorItem(contributor: contributors[index]);
              },
            );
          }
        },
      ),
    );
  }
}

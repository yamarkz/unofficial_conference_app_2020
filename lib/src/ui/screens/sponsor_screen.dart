import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unofficial_conference_app_2020/src/blocs/sponsor_screen_bloc.dart';
import 'package:unofficial_conference_app_2020/src/l10n/strings.dart';
import 'package:unofficial_conference_app_2020/src/models/sponsor_category.dart';
import 'package:unofficial_conference_app_2020/src/ui/common/sponsor_item.dart';
import 'package:unofficial_conference_app_2020/src/utility/tuple.dart';

class SponsorScreen extends StatelessWidget {
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
        Strings.of(context).sponsors,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final bloc = Provider.of<SponsorScreenBloc>(context);
    return Container(
      child: StreamBuilder<Tuple2<List<SponsorCategory>, bool>>(
        stream: bloc.sponsorCategoriesStream,
        initialData: bloc.sponsorCategoriesValue,
        builder: (_, snapshot) {
          final sponsorCategories = <SponsorCategory>[];
          var isLoading = true;
          if (snapshot.hasData) {
            sponsorCategories.addAll(snapshot.data.value1);
            isLoading = snapshot.data.value2;
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error'));
          } else if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return _buildListContent(context, sponsorCategories);
          }
        },
      ),
    );
  }

  Widget _buildListContent(
    BuildContext context,
    List<SponsorCategory> sponsorCategories,
  ) {
    final platinumSponsorItems = <Widget>[];
    final goldSponsorItems = <Widget>[];
    final supporterItems = <Widget>[];
    final committeeSupportItem = <Widget>[];

    sponsorCategories.forEach((sponsorCategory) {
      switch (sponsorCategory.categoryType.rawValue) {
        case 'PLATINUM':
          platinumSponsorItems.addAll(
            sponsorCategory.sponsors
                .map((sponsor) => SponsorItem(sponsor: sponsor)),
          );
          break;
        case 'GOLD':
          goldSponsorItems.addAll(
            sponsorCategory.sponsors
                .map((sponsor) => SponsorItem(sponsor: sponsor)),
          );
          break;
        case 'SUPPORTER':
          supporterItems.addAll(
            sponsorCategory.sponsors
                .map((sponsor) => SponsorItem(sponsor: sponsor)),
          );
          break;
        case 'COMMITTEE_SUPPORT':
          committeeSupportItem.addAll(
            sponsorCategory.sponsors
                .map((sponsor) => SponsorItem(sponsor: sponsor)),
          );
          break;
        default:
          return;
      }
    });

    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              Text(
                'PLATINUM SPONSORS',
                style: Theme.of(context).textTheme.headline,
              ),
              const SizedBox(height: 10),
            ]),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              platinumSponsorItems,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const Divider(thickness: 1, height: 30),
                Text(
                  'GOLD SPONSORS',
                  style: Theme.of(context).textTheme.headline,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            delegate: SliverChildListDelegate(
              goldSponsorItems,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const Divider(thickness: 1, height: 30),
                Text(
                  'SPONSORS',
                  style: Theme.of(context).textTheme.headline,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            delegate: SliverChildListDelegate(
              supporterItems,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const Divider(thickness: 1, height: 30),
                Text(
                  'TECHNICAL SUPPORT FOR NETWORK',
                  style: Theme.of(context).textTheme.headline,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            delegate: SliverChildListDelegate(
              committeeSupportItem,
            ),
          ),
        ],
      ),
    );
  }
}

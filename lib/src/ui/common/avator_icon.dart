import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:unofficial_conference_app_2020/src/utility/droid_kaigi_theme.dart';

class AvatarIcon extends StatelessWidget {
  final String imageUrl;
  final double radius;
  final double size;

  const AvatarIcon({
    Key key,
    @required this.imageUrl,
    this.radius = 50,
    this.size = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: null,
        child: Icon(
          Icons.person,
          size: size,
          color: DroidKaigiColors.white,
        ),
        backgroundColor: DroidKaigiColors.indigo400,
      );
    } else {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (_, __) => CircleAvatar(
          child: Container(),
          radius: radius,
        ),
        imageBuilder: (_, imageProvider) => CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: imageProvider,
          radius: radius,
        ),
        errorWidget: (_, u, e) => CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: CachedNetworkImageProvider(imageUrl),
          radius: radius,
        ),
      );
    }
  }
}

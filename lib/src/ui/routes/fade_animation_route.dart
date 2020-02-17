import 'package:flutter/material.dart';

class FadeAnimationRoute<T> extends MaterialPageRoute<T> {
  FadeAnimationRoute(
      {WidgetBuilder builder,
      RouteSettings settings,
      bool maintainState = true,
      bool fullscreenDialog = false})
      : super(
            builder: builder,
            settings: settings,
            maintainState: maintainState,
            fullscreenDialog: fullscreenDialog);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }

  @override
  @protected
  bool get hasScopedWillPopCallback {
    return true;
  }
}

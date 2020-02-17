import 'dart:io';

import 'package:flutter/cupertino.dart';

class StandardPageRoute<T> extends CupertinoPageRoute<T> {
  StandardPageRoute(
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
  @protected
  bool get hasScopedWillPopCallback {
    return Platform.isIOS ? super.hasScopedWillPopCallback : true;
  }
}

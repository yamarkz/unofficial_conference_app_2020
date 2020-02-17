import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class RemovableItemBloc {
  final _removedSubject = BehaviorSubject<bool>.seeded(false);

  void dispose() {
    _removedSubject.close();
  }

  void remove() {
    _removedSubject.sink.add(true);
  }
}

class RemovableItem extends StatefulWidget {
  final Widget child;
  final Duration opacityDuration;
  final Duration resizeDuration;
  final VoidCallback onDismissed;

  const RemovableItem({
    @required Key key,
    @required this.child,
    this.opacityDuration = const Duration(milliseconds: 400),
    this.resizeDuration = const Duration(milliseconds: 400),
    this.onDismissed,
  })  : assert(key != null),
        assert(opacityDuration != null),
        assert(resizeDuration != null),
        super(key: key);
  @override
  _RemovableItemState createState() => _RemovableItemState();
}

class _RemovableItemState extends State<RemovableItem>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  AnimationController _opacityController;
  Animation<double> _opacityAnimation;
  static const Curve _kOpacityTimeCurve = Curves.easeIn;
  AnimationController _resizeController;
  Animation<double> _resizeAnimation;
  static const Curve _kResizeTimeCurve = Curves.ease;

  Size _sizePriorToCollapse;
  StreamSubscription _removedSubscription;

  @override
  bool get wantKeepAlive => _resizeController?.isCompleted != true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _opacityController?.dispose();
    _resizeController?.dispose();
    _removedSubscription?.cancel();
    super.dispose();
  }

  void _startOpacityAnimation() {
    if (_opacityController != null) {
      return;
    }
    _opacityController =
        AnimationController(duration: widget.opacityDuration, vsync: this)
          ..addListener(_handleOpacityProgressChanged)
          ..addStatusListener((AnimationStatus status) => updateKeepAlive());
    _opacityController.forward();
    setState(() {
      _opacityAnimation = _opacityController
          .drive(
            CurveTween(curve: _kOpacityTimeCurve),
          )
          .drive(
            Tween<double>(
              begin: 1.0,
              end: 0.0,
            ),
          );
    });
  }

  void _handleOpacityProgressChanged() {
    if (_opacityController.isCompleted) {
      _startResizeAnimation();
    }
  }

  void _startResizeAnimation() {
    if (_resizeController != null) {
      return;
    }
    _resizeController =
        AnimationController(duration: widget.resizeDuration, vsync: this)
          ..addListener(_handleResizeProgressChanged)
          ..addStatusListener((AnimationStatus status) => updateKeepAlive());
    _resizeController.forward();
    setState(() {
      _sizePriorToCollapse = context.size;
      _resizeAnimation = _resizeController
          .drive(
            CurveTween(curve: _kResizeTimeCurve),
          )
          .drive(
            Tween<double>(
              begin: 1.0,
              end: 0.0,
            ),
          );
    });
  }

  void _handleResizeProgressChanged() {
    if (_resizeController.isCompleted) {
      if (widget.onDismissed != null) {
        widget.onDismissed();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (_removedSubscription == null) {
      _removedSubscription = Provider.of<RemovableItemBloc>(context)
          ._removedSubject
          .stream
          .where((removed) => removed)
          .listen((_) {
        _startOpacityAnimation();
      });
    }

    return _opacityTransition(
      child: _resizeTransition(
        child: widget.child,
      ),
    );
  }

  Widget _opacityTransition({@required Widget child}) {
    return _opacityAnimation != null
        ? FadeTransition(
            opacity: _opacityAnimation,
            child: child,
          )
        : child;
  }

  Widget _resizeTransition({@required Widget child}) {
    return _resizeAnimation != null
        ? SizeTransition(
            sizeFactor: _resizeAnimation,
            axis: Axis.vertical,
            child: SizedBox(
              width: _sizePriorToCollapse.width,
              height: _sizePriorToCollapse.height,
              child: child,
            ),
          )
        : child;
  }
}

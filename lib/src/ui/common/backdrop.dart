import 'package:flutter/material.dart';

const double _kFlingVelocity = 2.0;

class BackDrop extends StatefulWidget {
  final int currentIndex;
  final Function frontLayer;
  final Function backLayer;

  BackDrop({
    @required this.currentIndex,
    @required this.frontLayer,
    @required this.backLayer,
  });

  @override
  _BackDropState createState() => _BackDropState();
}

class _BackDropState extends State<BackDrop>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  AnimationController _controller;

  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop key');

  @override
  bool get wantKeepAlive => true;

  @override
  void didUpdateWidget(BackDrop old) {
    super.didUpdateWidget(old);
    if (widget.currentIndex != old.currentIndex) {
      _toggleBackDropLayerVisibility();
    } else if (!_isFrontLayerExpanded) {
      _controller.fling(velocity: _kFlingVelocity);
    }
  }

  initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      value: 1.0,
      vsync: this,
    );
    super.initState();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LayoutBuilder(builder: _buildBackDropStack);
  }

  bool get _isFrontLayerExpanded {
    final status = _controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  void _toggleBackDropLayerVisibility() {
    _controller.fling(
      velocity: _isFrontLayerExpanded ? -_kFlingVelocity : _kFlingVelocity,
    );
  }

  Widget _buildBackDropStack(BuildContext context, BoxConstraints constrains) {
    const layerTitleHeight = 130;
    final layerSize = constrains.biggest;
    final layerTop = layerSize.height - layerTitleHeight;

    final layerAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(0, layerTop, 0, layerTop - layerSize.height),
      end: const RelativeRect.fromLTRB(0, 0, 0, 0),
    ).animate(
      _controller.view,
    );

    return Stack(
      key: _backdropKey,
      children: <Widget>[
        ExcludeSemantics(
          child: widget.backLayer(context),
          excluding: _isFrontLayerExpanded,
        ),
        PositionedTransition(
          rect: layerAnimation,
          child: GestureDetector(
            onVerticalDragUpdate: (details) {
              if (details.primaryDelta > 0) {
                _controller.value -= details.primaryDelta / layerSize.height;
              } else {
                _controller.value -= details.primaryDelta / layerSize.height;
              }
            },
            onVerticalDragEnd: (DragEndDetails details) {
              if (details.primaryVelocity < 0) {
                _controller.fling(
                  velocity: -details.primaryVelocity / layerSize.height,
                );
              } else {
                _controller.fling(
                  velocity: -details.primaryVelocity / layerSize.height,
                );
              }
            },
            child: Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.translationValues(0, 0, 0),
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.only(top: 30),
                child: _FrontLayer(
                  child: widget.frontLayer(
                    context,
                    _toggleBackDropLayerVisibility,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _FrontLayer extends StatelessWidget {
  final Widget child;

  const _FrontLayer({
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(child: child),
        ],
      ),
    );
  }
}

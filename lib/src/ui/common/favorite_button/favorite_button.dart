import 'package:flutter/material.dart';
import 'package:unofficial_conference_app_2020/src/ui/common/favorite_button/painter/bubbles_painter.dart';
import 'package:unofficial_conference_app_2020/src/ui/common/favorite_button/painter/circle_painter.dart';
import 'package:unofficial_conference_app_2020/src/ui/common/favorite_button/utils/favorite_button_model.dart';

// MIT License
//
// Copyright (c) 2019 zmtzawqlp
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included
// in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

// ref: https://github.com/fluttercandies/like_button/blob/master/lib/src/like_button.dart
// Customized and used for this app.
// This implement is required refactoring.

// todo: rename from favorite to bookmark
class FavoriteButton extends StatefulWidget {
  ///size of favorite widget
  final double size;

  ///animation duration to change isFavorite state
  final Duration animationDuration;

  ///whether it is favorite
  final bool isFavorite;

  /// tap call back of favorite button
  final Function onTap;

  ///total size of bubbles
  final double bubblesSize;

  ///size of circle
  final double circleSize;

  ///colors of circle
  final CircleColor circleColor;

  ///colors of bubbles
  final BubblesColor bubblesColor;

  FavoriteButton({
    Key key,
    this.size = 30.0,
    this.animationDuration = const Duration(milliseconds: 1000),
    this.isFavorite = false,
    this.onTap,
    double bubblesSize,
    double circleSize,
    this.circleColor = const CircleColor(
      start: Color(0xFF01579b),
      end: Color(0xFF00b5e2),
    ),
    this.bubblesColor = const BubblesColor(
      dotPrimaryColor: Color(0xFF00b5e2),
      dotSecondaryColor: Color(0xFF03a9f4),
      dotThirdColor: Color(0xFF0288d1),
      dotLastColor: Color(0xFF01579b),
    ),
  })  : bubblesSize = bubblesSize ?? size * 2.0,
        circleSize = circleSize ?? size * 0.8,
        super(key: key);

  @override
  State<StatefulWidget> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _bubblesAnimation;
  Animation<double> _outerCircleAnimation;
  Animation<double> _innerCircleAnimation;
  Animation<double> _scaleAnimation;
  bool _isFavorite = false;
  bool _isFinishInit = false;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _initAnimations();
  }

  @override
  void didUpdateWidget(FavoriteButton oldWidget) {
    _isFavorite = widget.isFavorite;
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _initAnimations();
    if (_isFavorite && _isFinishInit && _isFavorite != oldWidget.isFavorite) {
      _controller.reset();
      _controller.forward();
    }
    if (!_isFinishInit) _isFinishInit = true;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _initAnimations() {
    _initControlAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (c, w) {
          return Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Positioned(
                top: (widget.size - widget.bubblesSize) / 2.0,
                left: (widget.size - widget.bubblesSize) / 2.0,
                child: CustomPaint(
                  size: Size(widget.bubblesSize, widget.bubblesSize),
                  painter: BubblesPainter(
                    currentProgress: _bubblesAnimation.value,
                    color1: widget.bubblesColor.dotPrimaryColor,
                    color2: widget.bubblesColor.dotSecondaryColor,
                    color3: widget.bubblesColor.dotThirdColor,
                    color4: widget.bubblesColor.dotLastColor,
                  ),
                ),
              ),
              Positioned(
                top: (widget.size - widget.bubblesSize) / 2.0,
                left: (widget.size - widget.bubblesSize) / 2.0,
                child: CustomPaint(
                  size: Size(widget.bubblesSize, widget.bubblesSize),
                  painter: CirclePainter(
                    innerCircleRadiusProgress: _innerCircleAnimation.value,
                    outerCircleRadiusProgress: _outerCircleAnimation.value,
                    circleColor: CircleColor(
                      start: widget.circleColor.start,
                      end: widget.circleColor.end,
                    ),
                  ),
                ),
              ),
              Container(
                width: widget.size,
                height: widget.size,
                alignment: Alignment.center,
                child: Transform.scale(
                  scale: _isFavorite && _controller.isAnimating
                      ? _scaleAnimation.value
                      : 1.0,
                  child: SizedBox(
                    width: widget.size,
                    height: widget.size,
                    child: Icon(
                      _isFavorite ? Icons.bookmark : Icons.bookmark_border,
                      color:
                          _isFavorite ? const Color(0xFF00b5e2) : Colors.grey,
                      size: widget.size,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _onTap() {
    if (_controller.isAnimating) return;
    if (widget.onTap != null) {
      widget.onTap();
    } else {
      _handleIsFavoriteChanged(!_isFavorite);
    }
  }

  void _handleIsFavoriteChanged(bool isFavorite) {
    if (isFavorite != null && isFavorite != _isFavorite) {
      _isFavorite = isFavorite;
      if (mounted) {
        setState(() {
          if (_isFavorite) {
            _controller.reset();
            _controller.forward();
          }
        });
      }
      return;
    }
  }

  void _initControlAnimation() {
    _outerCircleAnimation = Tween<double>(
      begin: 0.1,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.0,
          0.3,
          curve: Curves.ease,
        ),
      ),
    );
    _innerCircleAnimation = Tween<double>(
      begin: 0.2,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.2,
          0.5,
          curve: Curves.ease,
        ),
      ),
    );
    _scaleAnimation = Tween<double>(
      begin: 0.2,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.35,
          0.7,
          curve: OvershootCurve(),
        ),
      ),
    );
    _bubblesAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.1,
          1.0,
          curve: Curves.decelerate,
        ),
      ),
    );
  }
}

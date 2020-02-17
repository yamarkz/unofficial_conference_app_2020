import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:unofficial_conference_app_2020/src/utility/droid_kaigi_theme.dart';

class TagButton extends StatefulWidget {
  final String name;
  final Object obj;
  final Function change;
  final PublishSubject<bool> resetSubject;

  TagButton({
    @required this.name,
    @required this.obj,
    @required this.change,
    @required this.resetSubject,
  });

  @override
  _TagButtonState createState() => _TagButtonState();
}

class _TagButtonState extends State<TagButton> {
  bool _selected = false;

  @override
  initState() {
    widget.resetSubject?.listen((data) => select(!data));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButton(
      textSelected: widget.name,
      textUnselected: widget.name,
      selected: _selected,
      onChange: select,
    );
  }

  void select(dynamic value) {
    if (!mounted) return;
    setState(() {
      widget.change(widget.obj, value);
      _selected = value;
    });
  }
}

class ToggleButton extends StatelessWidget {
  final bool selected;
  final Function onChange;
  final String textSelected;
  final String textUnselected;

  ToggleButton({
    this.textSelected,
    this.textUnselected,
    this.selected,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 200),
      crossFadeState:
          selected ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      firstChild: FlatButton(
        color: DroidKaigiColors.lightBlue300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              textSelected,
              style: TextStyle(
                fontSize: 14,
                color: DroidKaigiColors.blackAlpha87,
              ),
            ),
            const SizedBox(width: 5),
            Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: DroidKaigiColors.blackAlpha38,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                size: 12,
                color: DroidKaigiColors.lightBlue300,
              ),
            ),
          ],
        ),
        onPressed: () {
          onChange(false);
        },
      ),
      secondChild: FlatButton(
        color: DroidKaigiColors.indigo400,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: DroidKaigiColors.lightBlue300,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                size: 12,
                color: DroidKaigiColors.lightBlue300,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              textUnselected,
              style: TextStyle(
                fontSize: 14,
                color: DroidKaigiColors.white,
              ),
            ),
          ],
        ),
        onPressed: () {
          onChange(true);
        },
      ),
    );
  }
}

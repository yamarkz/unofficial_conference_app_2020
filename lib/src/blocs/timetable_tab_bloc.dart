import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

enum TimetableTabType {
  appBars,
  backdrop,
  cards,
  dialogs,
  pickers,
  sliders,
  tabs,
}

class TimetableTabTypeHelper {
  TimetableTabTypeHelper._();
  static int index(TimetableTabType type) {
    return TimetableTabType.values.indexOf(type);
  }

  static TimetableTabType type(int index) {
    return 0 <= index && index < TimetableTabType.values.length
        ? TimetableTabType.values[index]
        : null;
  }

  static int roomId(TimetableTabType type) {
    switch (type) {
      case TimetableTabType.appBars:
        return 11511;
      case TimetableTabType.backdrop:
        return 11512;
      case TimetableTabType.cards:
        return 11513;
      case TimetableTabType.dialogs:
        return 11514;
      case TimetableTabType.pickers:
        return 11515;
      case TimetableTabType.sliders:
        return 11516;
      case TimetableTabType.tabs:
        return 11517;
      default:
        return null;
    }
  }
}

class TimetableTabBloc {
  static TimetableTabBloc _shared;

  factory TimetableTabBloc() => _shared ??= TimetableTabBloc._();

  TimetableTabBloc._();

  void dispose() {
    _changeIndexSubject.close();
    _shared = null;
  }

  static TimetableTabBloc get shared => _shared;

  int _index = 0;

  int get index => _index;

  void setIndex(int index) {
    _index = index;
    _changeIndexSubject.sink.add(_index);
  }

  final _changeIndexSubject = BehaviorSubject<int>.seeded(0);
  Observable<int> get changeIndexStream => _changeIndexSubject.stream;

  TabController _tabController;

  set tabController(TabController tabController) {
    final before = _tabController;
    _tabController = tabController;
    if (before != _tabController) {
      before?.dispose();
      _tabController?.addListener(() {
        _changeIndexSubject.sink.add(_tabController.index);
      });
    }
  }

  TabController get tabController => _tabController;
}

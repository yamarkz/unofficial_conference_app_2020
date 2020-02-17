import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

enum TabType {
  day1,
  day2,
  myPlan,
}

class TabTypeHelper {
  TabTypeHelper._();
  static int index(TabType type) {
    return TabType.values.indexOf(type);
  }

  static TabType type(int index) {
    return 0 <= index && index < TabType.values.length
        ? TabType.values[index]
        : null;
  }

  static int day(TabType type) {
    switch (type) {
      case TabType.day1:
        return 1;
      case TabType.day2:
        return 2;
      case TabType.myPlan:
        return null;
      default:
        return null;
    }
  }
}

class TabBloc {
  static TabBloc _shared;

  factory TabBloc() => _shared ??= TabBloc._();

  TabBloc._();

  void dispose() {
    _changeIndexSubject.close();
    _shared = null;
  }

  static TabBloc get shared => _shared;

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

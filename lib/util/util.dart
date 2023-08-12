import 'dart:async';

import 'package:flutter/material.dart';

//#region Debounce
class _Process {
  final String name;
  final Function target;
  final Timer timer;

  _Process(this.name, this.target, this.timer);
}

List<_Process> _timeouts = List.empty(growable: true);
List<void Function()> _pendingRemovals = List.empty(growable: true);

/// Use for delayed execution
void debounce(Duration timeout, String processName, Function target,
    [List arguments = const []]) {
  for (var e in _timeouts) {
    if (e.name == processName) {
      e.timer.cancel();
      _pendingRemovals.add(() {
        _timeouts.remove(e);
      });
    }
  }

  Timer timer = Timer(timeout, () {
    Function.apply(target, arguments);
  });

  _timeouts.add(_Process(processName, target, timer));

  for (var e in _pendingRemovals) {
    e();
  }
}
//#endregion

SizedBox addVerticaLSpace(double spaceHeight) {
  return SizedBox(height: spaceHeight);
}
SizedBox addHorizontalSpace(double spaceWidth) {
  return SizedBox(width: spaceWidth);
}

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

/// Only use with unique values!
dynamic getKeyfromValue(Map map, dynamic value) {
  return map.keys.firstWhere(((e) => map[e] == value));
}

SizedBox addVerticaLSpace(double spaceHeight) {
  return SizedBox(height: spaceHeight);
}

SizedBox addHorizontalSpace(double spaceWidth) {
  return SizedBox(width: spaceWidth);
}

PageRouteBuilder<dynamic> slideInAnim(Widget target) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => target,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      final tween =
          Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      final offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

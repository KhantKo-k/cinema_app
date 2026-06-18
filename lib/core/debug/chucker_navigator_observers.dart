import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';

List<NavigatorObserver> debugNavigatorObservers() => [
      ChuckerFlutter.navigatorObserver,
    ];

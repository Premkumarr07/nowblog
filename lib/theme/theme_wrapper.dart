// lib/theme/theme_wrapper.dart
import 'package:flutter/material.dart';

class ThemeWrapper extends StatefulWidget {
  final Widget child;
  const ThemeWrapper({Key? key, required this.child}) : super(key: key);

  static _ThemeWrapperState of(BuildContext context) {
    final _ThemeWrapperState? result =
    context.findAncestorStateOfType<_ThemeWrapperState>();
    assert(result != null, 'No ThemeWrapper found in context');
    return result!;
  }

  @override
  _ThemeWrapperState createState() => _ThemeWrapperState();
}

class _ThemeWrapperState extends State<ThemeWrapper> {
  bool _isDarkMode = false;
  bool _isPrimaryColorBlue = true;

  bool get isDarkMode => _isDarkMode;
  bool get isPrimaryColorBlue => _isPrimaryColorBlue;

  void toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void togglePrimaryColor() {
    setState(() {
      _isPrimaryColorBlue = !_isPrimaryColorBlue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

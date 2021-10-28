import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_world/ui/widgets/progress_view.dart';

var _context;
BuildContext? _dismissingContext;
bool _isShowing = false;
bool? _barrierDismissible = true, _showLogs;

Curve _insetAnimCurve = Curves.easeInOut;

class ProgressDialog {
  ProgressDialog(BuildContext context) {
    _context = context;
  }

  Future<bool> hide() {
    if (_isShowing) {
      try {
        _isShowing = false;
        Navigator.of(_context).pop(true);
        // if (_showLogs) debugPrint('ProgressDialog dismissed');
        return Future.value(true);
      } catch (_) {
        return Future.value(false);
      }
    } else {
      // if (_showLogs) debugPrint('ProgressDialog already dismissed');
      return Future.value(false);
    }
  }

  void show() {
    if (!_isShowing) {
      _isShowing = true;
      showDialog<dynamic>(
        context: _context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          _dismissingContext = context;
          return WillPopScope(
            onWillPop: () {
              return Future.value(_barrierDismissible);
            },
            child: Dialog(
              backgroundColor: Colors.transparent,
              insetAnimationCurve: _insetAnimCurve,
              insetAnimationDuration: Duration(milliseconds: 100),
              elevation: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[ProgressView()],
              ),
            ),
          );
        },
      );
    }
  }
}

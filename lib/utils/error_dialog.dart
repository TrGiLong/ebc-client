import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

extension BuildContextError on BuildContext {
  showError(String message) {
    showPlatformDialog(
        context: this,
        builder: (context) {
          return PlatformAlertDialog(
            title: Text("Alert"),
            content: Text(message),
            actions: [
              PlatformDialogAction(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}

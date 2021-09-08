import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class InsertBlockScreen extends StatefulWidget {
  final Function(String) onAdd;

  const InsertBlockScreen({Key? key, required this.onAdd}) : super(key: key);

  @override
  _InsertBlockScreenState createState() => _InsertBlockScreenState();
}

class _InsertBlockScreenState extends State<InsertBlockScreen> {
  final TextEditingController controller = TextEditingController(text: "http://demo.com");

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  String _errorString() {
    if (controller.text.isEmpty) return "";
    if (_isUrlValid()) {
      return "";
    }
    return "No valid url";
  }

  bool _isUrlValid() {
    final regex = RegExp(r"^(?:http|https):\/\/[\w\-_]+(?:\.[\w\-_]+)+[\w\-.,@?^=%&:/~\\+#]*$");
    final match = regex.firstMatch(controller.text);
    return match != null;
  }

  @override
  Widget build(BuildContext context) {
    return PlatformAlertDialog(
      key: Key("add-alert"),
      title: Text("New block"),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PlatformTextField(
              key: Key("input"),
              controller: controller,
              onChanged: (value) {
                setState(() {});
              },
            ),
            if (_errorString().isNotEmpty) Text(_errorString()),
          ],
        ),
      ),
      actions: [
        PlatformDialogAction(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        PlatformDialogAction(
          child: Text("Insert"),
          onPressed: _isUrlValid()
              ? () {
                  widget.onAdd.call(controller.text);
                  Navigator.of(context).pop();
                }
              : null,
        ),
      ],
    );
  }
}

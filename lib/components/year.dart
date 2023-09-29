import 'package:flutter/material.dart';

class YearPickerDialog extends StatefulWidget {
  @override
  _YearPickerDialogState createState() => _YearPickerDialogState();
}

class _YearPickerDialogState extends State<YearPickerDialog> {
  int selectedYear = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Year'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 200.0,
            child: YearPicker(
              selectedDate: DateTime(selectedYear),
              firstDate: DateTime(DateTime.now().year - 100),
              lastDate: DateTime(DateTime.now().year + 100),
              onChanged: (DateTime year) {
                setState(() {
                  selectedYear = year.year;
                });
              },
            ),
          ),
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(selectedYear);
            },
          ),
        ],
      ),
    );
  }
}

Future<int?> showYearPickerDialog(BuildContext context) async {
  return showDialog<int>(
    context: context,
    builder: (BuildContext context) {
      return YearPickerDialog();
    },
  );
}

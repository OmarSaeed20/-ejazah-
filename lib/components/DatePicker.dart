import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerWidget extends StatefulWidget {
  final DateTime? birthday;
  final ValueChanged<DateTime>? onChangedBirthday;

  const DatePickerWidget({
    Key? key,
    @required this.birthday,
    @required this.onChangedBirthday,
  }) : super(key: key);

  @override
  _BirthdayWidgetState createState() => _BirthdayWidgetState();
}

class _BirthdayWidgetState extends State<DatePickerWidget> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    setDate();
  }

  @override
  void didUpdateWidget(covariant DatePickerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    setDate();
  }

  void setDate() => setState(() {
    controller.text = widget.birthday == null
        ? ''
        : DateFormat.yMd().format(widget.birthday!);
  });

  @override
  Widget build(BuildContext context) => FocusBuilder(
    onChangeVisibility: (isVisible) {
      if (isVisible) {
        selectDate(context);
        //
      } else {
        FocusScope.of(context).requestFocus(FocusNode());
      }
    },
    focusNode: focusNode,
    builder: (hasFocus) => TextFormField(
      controller: controller,
      validator: (value) => value!.isEmpty ? 'Is Required' : null,
      decoration: InputDecoration(
        prefixText: ' ',
        hintText: 'Pick Date',
        prefixIcon: Icon(Icons.calendar_today_rounded),
        border: OutlineInputBorder(),
      ),
    ),
  );

  Future selectDate(BuildContext context) async {
    final birthday = await showDatePicker(
      context: context,
      initialDate: widget.birthday ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );

    if (birthday == null) return;

    widget.onChangedBirthday!(birthday);
  }
}

class FocusBuilder extends StatefulWidget {
  final FocusNode? focusNode;
  final Widget Function(bool hasFocus)? builder;
  final ValueChanged<bool>? onChangeVisibility;

  const FocusBuilder({
    @required this.focusNode,
    @required this.builder,
    @required this.onChangeVisibility,
    Key? key,
  }) : super(key: key);

  @override
  _FocusBuilderState createState() => _FocusBuilderState();
}

class _FocusBuilderState extends State<FocusBuilder> {
  @override
  Widget build(BuildContext context) => GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () => widget.onChangeVisibility!(true),
    child: Focus(
      focusNode: widget.focusNode,
      onFocusChange: widget.onChangeVisibility,
      child: widget.builder!(widget.focusNode!.hasFocus),
    ),
  );
}
Widget defaultFormField({
  required TextEditingController? controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  bool isPassword = false,
  required Function validate,
  required String label,
  required IconData iconprefix,
  IconData? iconsuffix,
  Function? suffixpressed,
  bool isClicable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClicable,
      onFieldSubmitted: (s) {
        onSubmit!(s);
      },
      onChanged: (s) {
        onChange!(s);
      },
      onTap: () {
        onTap!();
      },
      validator: (s) {
        return validate(s);
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          iconprefix,
        ),
        suffixIcon: iconsuffix != null
            ? IconButton(
          onPressed: () {
            suffixpressed!();
          },
          icon: Icon(
            iconsuffix,
          ),
        )
            : null,
        border: OutlineInputBorder(),
      ),
    );

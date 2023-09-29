import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import '../widgets/app_fonts.dart';

Future<bool?> toastShow({
  required String text,
  ToastStates state = ToastStates.black,
}) async {
  return Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

enum ToastStates { success, error, warning, black }

Color chooseToastColor(ToastStates state) {
  const Map<ToastStates, Color> toastColors = {
    ToastStates.success: Colors.green,
    ToastStates.warning: Colors.amber,
    ToastStates.error: Colors.red,
    ToastStates.black: Colors.black,
  };
  return toastColors[state]!;
}

Widget customTextFormField({
  required BuildContext context,
  required controller,
  required hintText,
  void Function(String val)? onFieldSubmitted,
  void Function(String val)? onChanged,
  required TextInputType keyboardType,
  required String? Function(String? val) validator,
  dynamic prefixIcon,
  IconData? suffixIcon,
  void Function()? suffixIconOnPressed,
  TextDirection textDirection = TextDirection.rtl,
  TextInputAction textInputAction = TextInputAction.next,
  bool obscureText = false,
  Function()? onTap,
  bool readOnly = false,
  int? maxLength,
  int maxLines = 1,
  bool? enableInteractiveSelection,
  Color? color,
  bool isCountry = false,
  String? code,
  String? flag,
  VoidCallback? callback,
}) {
  return Theme(
    data: ThemeData().copyWith(
      colorScheme: ThemeData().colorScheme.copyWith(
            primary: Colors.blue,
          ),
    ),
    child: Container(
      height: maxLines != 1 ? null : 45,
      child: Row(
        children: [
          isCountry
              ? InkWell(
                  onTap: callback,
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.network(
                          '${flag}',
                          height: 3.0.h,
                          width: 4.0.h,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(width: 1.0.w),
                      Text(
                        '${code}',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Tajawal",
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 0.5.h, horizontal: 1.5.w),
                        width: .40,
                        height: 40.0,
                        color: const Color(0xff7A716E),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
          Expanded(
            child: TextFormField(
              enableInteractiveSelection: enableInteractiveSelection,
              maxLength: maxLength,
              controller: controller,
              onTap: onTap,
              readOnly: readOnly,
              textInputAction: textInputAction,
              keyboardType: keyboardType,
              onFieldSubmitted: onFieldSubmitted,
              onChanged: onChanged,
              validator: validator,
              obscureText: obscureText,
              textDirection: textDirection,
              autocorrect: false,
              maxLines: maxLines,
              style: TextStyle(fontFamily: "Tajawal"),
              decoration: InputDecoration(
                errorStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Colors.red[900],
                      fontWeight: FontWeight.bold,
                      fontFamily: "Tajawal",
                    ),
                filled: true,
                fillColor: color ?? Colors.white,
                contentPadding: const EdgeInsets.all(10),
                hintText: hintText,
                hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: const Color(0xff7A716E), fontFamily: "Tajawal"),
                alignLabelWithHint: true,
                labelStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: const Color(0xff7A716E), fontFamily: "Tajawal"),
                prefixIcon: (prefixIcon is IconData)
                    ? Icon(prefixIcon)
                    : (prefixIcon is Widget)
                        ? prefixIcon
                        : null,
                suffixIcon: suffixIcon == null
                    ? null
                    : IconButton(
                        onPressed: suffixIconOnPressed,
                        icon: Icon(
                          suffixIcon,
                          color: Colors.black54,
                          size: AppFonts.t1,
                        ),
                      ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

String validText(String text) => "يرجي ادخال $text بطريقة صحيحة اولا";
String validTextLen(String text, int min) =>
    "$text يتكون من $min احرف علي الاقل";
String validNumLen(String text, int min) =>
    "$text يتكون من $min ارقام علي الاقل";

Widget underMaintenance() {
  return Scaffold(
    // backgroundColor: AppColor.backGroundColor,
    // bottomNavigationBar: CustomBottomNavBar(
    //   navigationTabsIndex: 3,
    // ),
    body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/under_maintenance.jpg'),
          SizedBox(height: 50),
          Text(
            'تحت الإنشاء',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.amber[800],
            ),
          ),
        ],
      ),
    ),
  );
}

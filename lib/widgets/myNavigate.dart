// ignore_for_file: body_might_complete_normally_nullable, file_names

import 'package:flutter/cupertino.dart';

Future myNavigate(
    {required Widget screen,
    bool withBackButton = true,
    required BuildContext context}) async {
  if (withBackButton == true) {
   return await Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => screen,
          transitionsBuilder: (c, anim, a2, child) =>
              FadeTransition(opacity: anim, child: child),
          transitionDuration: const Duration(milliseconds: 300),
        ));
  } else {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => screen,
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}

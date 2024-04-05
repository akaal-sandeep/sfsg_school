import 'package:flutter/material.dart';
import 'package:web_school_manager/utility/helper_widget.dart';

import '../widget/header.dart';

class DateSheet extends StatelessWidget {
  const DateSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPadding(
        child: Column(
          children: [
            CommonHeader(title: "Date Sheet",)
          ],
        ),
      ),
    );
  }
}

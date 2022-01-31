import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class AppBarTitleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset(
          'assets/images/logoo.png',
          width: 135.0,
          height: 110.0,
          fit: BoxFit.fill,
        ),
        SizedBox(
          width: 5,
        ),
      ],
    );
  }
}

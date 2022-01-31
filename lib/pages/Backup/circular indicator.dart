import 'package:doctor_appointment_booking/blocs/DatabaseBloc.dart';
import 'package:doctor_appointment_booking/pages/Backup/utils1.dart';
import 'package:doctor_appointment_booking/pages/home/home.dart';
import 'package:doctor_appointment_booking/utils/common_methods.dart';
import 'package:doctor_appointment_booking/utils/constants.dart';
import 'package:flutter/material.dart';

import 'dart:math' as math;
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import 'Backup.dart';

final customWidth08 =
    CustomSliderWidths(trackWidth: 1, progressBarWidth: 15, shadowWidth: 50);
final customColors08 = CustomSliderColors(
    dotColor: Colors.white.withOpacity(0.5),
    trackColor: HexColor('#ffFFFF'),
    progressBarColors: [
      kColorPrimary,
      kColorPrimary,
      kColorPrimary,
    ],
    shadowColor: HexColor('#133657'),
    shadowMaxOpacity: 0.02);

final CircularSliderAppearance appearance08 = CircularSliderAppearance(
    customWidths: customWidth08,
    customColors: customColors08,
    size: 230.0,
    spinnerMode: true,
    spinnerDuration: 1000);
final viewModel08 =
    ExampleViewModel(appearance: appearance08, value: 50, pageColors: [
  HexColor('#ffffff'),
  HexColor('#ffffff'),
  HexColor('#ffffff'),
  HexColor('#ffffff')
]);
final example08 = ExamplePage(
  viewModel: viewModel08,
);

String printDuration(Duration duration) {
  String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
}

class Backup extends StatefulWidget {
  Backup({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Backup> {
  final controller = PageController(initialPage: 0);
  final bloc = QRDataBloc();
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child: PageView(
      controller: controller,
      children: <Widget>[
        example08,
      ],
    ));
  }


  goHome()
  {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),));
  }
}

double degreeToRadians(double degree) {
  return (math.pi / 180) * degree;
}

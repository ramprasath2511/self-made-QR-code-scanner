import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:doctor_appointment_booking/routes/routes.dart';

import '../model/Patient.dart';
import '../utils/constants.dart';
import 'custom_button.dart';

class MyPatientListItem extends StatelessWidget {
  final Patient patient;

  const MyPatientListItem({Key key, @required this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffEBF2F5),
      ),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage(
              patient.avatar,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  patient.name,
                  style: TextStyle(
                    color: kColorPrimaryDark,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  patient.speciality + '\n',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          CustomButton(
            text: 'details'.tr(),
            textSize: 14,
            onPressed: () =>
                Navigator.of(context).pushNamed(Routes.patientvistpage),
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 5,
            ),
          )
        ],
      ),
    );
  }
}

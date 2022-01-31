import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../routes/routes.dart';
import 'custom_button.dart';
import 'custom_outline_button.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class UpcomingAppointmentPatientListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: _buildColumn(
                          context: context,
                          title: 'date'.tr(),
                          subtitle: '18 Juin 2020',
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: _buildColumn(
                          context: context,
                          title: 'time'.tr(),
                          subtitle: '09:30',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: _buildColumn(
                          context: context,
                          title: 'doctor'.tr(),
                          subtitle: 'Dr. Tawfiq Bahri',
                        ),
                      ),
                      Expanded(
                        child: _buildColumn(
                          context: context,
                          title: 'speciality'.tr(),
                          subtitle: 'Family Doctor',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: CustomButton(
                      text: 'Edit'.tr(),
                      textSize: 14,
                      onPressed: () {
                        Navigator.of(context).pushNamed(Routes.bookingStep3);
                      },
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: double.infinity,
                    child: CustomOutlineButton(
                      text: 'cancel'.tr(),
                      textSize: 14,
                      onPressed: () => _showAlert(context),
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Column _buildColumn({
    @required BuildContext context,
    @required String title,
    @required subtitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          subtitle,
          style: Theme.of(context)
              .textTheme
              .subtitle1
              .copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

_showAlert(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Cancel Doctor Appoinment'),
        content: Text("Are You Sure Want To Proceed ?"),
        actions: <Widget>[
          FlatButton(
            child: Text("YES"),
            onPressed: () {
              //Put your code here which you want to execute on Yes button click.
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text("NO"),
            onPressed: () {
              //Put your code here which you want to execute on No button click.
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

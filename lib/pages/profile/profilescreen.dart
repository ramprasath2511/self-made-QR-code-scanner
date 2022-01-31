import 'dart:io';

import 'package:doctor_appointment_booking/blocs/update_bloc.dart';
import 'package:doctor_appointment_booking/model/backup_email_provider.dart';
import 'package:doctor_appointment_booking/model/update_model.dart';
import 'package:doctor_appointment_booking/netwoking/ApiProvider.dart';
import 'package:doctor_appointment_booking/netwoking/Repsonse.dart';
import 'package:doctor_appointment_booking/pages/home/home.dart';
import 'package:doctor_appointment_booking/utils/common_methods.dart';
import 'package:doctor_appointment_booking/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widgets/custom_shape.dart';
import 'widgets/customappbar.dart';
import 'widgets/responsive_ui.dart';
import 'widgets/textformfield.dart';
import 'package:provider/provider.dart';

class profile extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  bool checkBoxValue = false;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  File _image;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  String networkImage="";
  @override
  void initState() {
    getUserData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
        print('Image Path $_image');
      });
    }

    return Material(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Profile',
            style: TextStyle(fontSize: 22, color: kColorPrimary),
          ),
        ),
        body: Container(
          height: _height,
          width: _width,
          margin: EdgeInsets.only(bottom: 5),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(left: 35.0, top: 35),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Color(0xff476cfb),
                          child: ClipOval(
                            child: new SizedBox(
                              width: 180.0,
                              height: 180.0,
                              child: (_image != null)
                                  ? Image.file(
                                      _image,
                                      fit: BoxFit.fill,
                                    )
                                  : Consumer<EmailProvider>(
                                  builder: (context, data, child)
                                  {
                                    return
                                      CircleAvatar(
                                        radius: 40,
                                        backgroundColor: Colors.grey,
                                        backgroundImage: data.profileImage!=null&& data.profileImage!=""?
                                        NetworkImage(data.profileImage):AssetImage(
                                          'assets/images/220px-Matthew_Perry_as_Chandler_Bing.png',
                                        ),
                                      );
                                  }
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 60.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.edit,
                          size: 30.0,
                        ),
                        onPressed: () {
                          getImage();
                        },
                      ),
                    ),
                  ],
                ), //profile picture
                form(),

                SizedBox(
                  height: _height / 30,
                ),
                button(context),

                //signInTextRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget clipShape() {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: _large
                  ? _height / 8
                  : (_medium ? _height / 7 : _height / 6.5),
              decoration: BoxDecoration(),
            ),
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: ClipPath(
            clipper: CustomShapeClipper2(),
            child: Container(
              height: _large
                  ? _height / 12
                  : (_medium ? _height / 11 : _height / 10),
              decoration: BoxDecoration(),
            ),
          ),
        ),

      ],
    );
  }

  Widget form() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0, right: _width / 12.0, top: _height / 12.0),
      child: Form(
        child: Column(
          children: <Widget>[
            firstNameTextFormField(),
            SizedBox(height: _height / 35.0),
            emailTextFormField(),
            SizedBox(height: _height / 35.0),
            //phoneTextFormField(),
            //SizedBox(height: _height / 35.0),
            passwordTextFormField(),
          ],
        ),
      ),
    );
  }

  Widget firstNameTextFormField() {
    return CustomTextField(
      textEditingController: nameController,
      keyboardType: TextInputType.text,
      icon: Icons.person,
      hint: "Name",
    );
  }

  Widget lastNameTextFormField() {
    return CustomTextField(

      keyboardType: TextInputType.text,
      icon: Icons.person,
      hint: "",
    );
  }

  Widget emailTextFormField() {
    return CustomTextField(
      textEditingController: emailController,
      keyboardType: TextInputType.emailAddress,
      icon: Icons.email,
      hint: "Email ID",
    );
  }

  Widget phoneTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.number,
      icon: Icons.calendar_today_sharp,
      hint: "Date of Birth",
    );
  }

  Widget passwordTextFormField() {
    return CustomTextField(
      textEditingController: phoneController,
      keyboardType: TextInputType.number,
      obscureText: true,
      icon: Icons.phone_android,
      hint: "Phone number",
    );
  }

  Widget acceptTermsTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 100.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Checkbox(
              activeColor: Colors.greenAccent,
              value: checkBoxValue,
              onChanged: (bool newValue) {
                setState(() {
                  checkBoxValue = newValue;
                });
              }),
          Text(
            "I accept all terms and conditions",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: _large ? 12 : (_medium ? 11 : 10)),
          ),
        ],
      ),
    );
  }

  @override
  Widget button(BuildContext context) {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () async{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        if(isValid(context))
          {
            bodyData = {
              "email": emailController.text.toString(),
              "name": nameController.text.toString(),
              "mobile": phoneController.text.toString(),
              "userId": prefs.getString("id")
            };
            ApiProvider apiProvider = ApiProvider();
            apiProvider.uploadImage(_image, "Api/update_user_profile",nameController.text.toString(),emailController.text.toString(),phoneController.text.toString(),context);
            //callUpdateAPI(context);
          }
      },
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
//        height: _height / 20,
        width: _large ? _width / 4 : (_medium ? _width / 3.75 : _width / 3.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: kColorPrimary,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Text(
          'Save',
          style: TextStyle(
              fontSize: _large ? 20 : (_medium ? 25 : 15), color: Colors.white),
        ),
      ),
    );
  }

  Widget infoTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Or create using social media",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: _large ? 12 : (_medium ? 11 : 10)),
          ),
        ],
      ),
    );
  }

  Widget socialIconsRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 80.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircleAvatar(
            radius: 15,
            backgroundImage: AssetImage("assets/images/googlelogo.png"),
          ),
          SizedBox(
            width: 20,
          ),
          CircleAvatar(
            radius: 15,
            backgroundImage: AssetImage("assets/images/fblogo.jpg"),
          ),
          SizedBox(
            width: 20,
          ),
          CircleAvatar(
            radius: 15,
            backgroundImage: AssetImage("assets/images/twitterlogo.jpg"),
          ),
        ],
      ),
    );
  }

  Widget signInTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Already have an account?",
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              // driver p
            },
            child: Text(
              "Sign in",
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.orange[200],
                  fontSize: 19),
            ),
          )
        ],
      ),
    );
  }

   getUserData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    nameController.text = prefs.getString("name");
    emailController.text = prefs.getString("email");
    phoneController.text = prefs.getString("mobile");
    if(prefs.getString("profile")!=null)
      {
        networkImage = prefs.getString("profile");
      }


   }

  bool isValid(BuildContext context) {
    if(nameController.text.isEmpty)
      {
        CommonMethod.showToast(context, "Enter name");
        return false;
      }
    // if(phoneController.text.isEmpty)
    // {
    //   CommonMethod.showToast(context, "Enter mobile");
    //   return false;
    // }
    // if(emailController.text.isEmpty)
    // {
    //   CommonMethod.showToast(context, "Enter email");
    //   return false;
    // }
    return true;
  }

  UpdateBloc _bloc;
  var bodyData;
  UpdateModel _updateModel;
  void callUpdateAPI(BuildContext context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bodyData = {
      "email": emailController.text.toString(),
      "name": nameController.text.toString(),
      "mobile": phoneController.text.toString(),
      "userId": prefs.getString("id")
    };
    _bloc = new UpdateBloc(bodyData);
    _bloc.chuckListStream.listen((onData) {
    _updateModel = onData.data;
      //print(onData.status);
      if (onData.status == Status.LOADING) {
        // _playAnimation();
      } else if (onData.status == Status.COMPLETED) {
        if (_updateModel.success == 1) {
          CommonMethod.setPreference(context, "name", _updateModel.data.name);
          CommonMethod.setPreference(context, "email", _updateModel.data.email);
          CommonMethod.setPreference(context, "mobile", _updateModel.data.mobile);
          CommonMethod.setPreference(context, "id", _updateModel.data.id);
          CommonMethod.setPreference(context, "profile", _updateModel.data.profilePic);
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),));
          goToHome(context);
        } else {
          CommonMethod.showToast(context, _updateModel.msg);

        }
      } else if (onData.status == Status.ERROR) {

      }
    });
  }

  void goToHome(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
  }
}

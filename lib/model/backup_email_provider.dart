import 'package:flutter/foundation.dart';

class EmailProvider extends ChangeNotifier{

  String email;
  String getValue() => email;
  void setEmail(String val) {
    // This call tells th'e widgets that are listening to this model to rebuild.
    email = val;

    notifyListeners();
  }

//image
  String profileImage="";
  String getProfileImage() => profileImage;
  void setProfileImage(String val) {
    // This call tells th'e widgets that are listening to this model to rebuild.
    profileImage = val;

    notifyListeners();
  }


}
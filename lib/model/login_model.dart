class LoginModel {
  int success;
  String msg;
  Data data;

  LoginModel({this.success, this.msg, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String roleId;
  String email;
  String name;
  String mobile;
  String profilePic;
  Null googleId;
  Null appleId;
  String isDeleted;
  String isVerify;
  String createdDtm;
  String id;

  Data(
      {this.roleId,
        this.email,
        this.name,
        this.mobile,
        this.profilePic,
        this.googleId,
        this.appleId,
        this.isDeleted,
        this.isVerify,
        this.createdDtm,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    roleId = json['roleId'];
    email = json['email'];
    name = json['name'];
    mobile = json['mobile'];
    profilePic = json['profile_pic'];
    googleId = json['google_id'];
    appleId = json['apple_id'];
    isDeleted = json['isDeleted'];
    isVerify = json['is_verify'];
    createdDtm = json['createdDtm'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roleId'] = this.roleId;
    data['email'] = this.email;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['profile_pic'] = this.profilePic;
    data['google_id'] = this.googleId;
    data['apple_id'] = this.appleId;
    data['isDeleted'] = this.isDeleted;
    data['is_verify'] = this.isVerify;
    data['createdDtm'] = this.createdDtm;
    data['id'] = this.id;
    return data;
  }
}

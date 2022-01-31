class SecreteCodeModel {
  int success;
  String msg;
  List<Data> data;

  SecreteCodeModel({this.success, this.msg, this.data});

  SecreteCodeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String secretId;
  String name;
  String createdDtm;

  Data({this.secretId, this.name, this.createdDtm});

  Data.fromJson(Map<String, dynamic> json) {
    secretId = json['secretId'];
    name = json['name'];
    createdDtm = json['createdDtm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['secretId'] = this.secretId;
    data['name'] = this.name;
    data['createdDtm'] = this.createdDtm;
    return data;
  }
}

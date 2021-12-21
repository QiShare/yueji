class LoginModel {
  int code;
  String email;
  String msg;
  String token;

  LoginModel({this.code, this.email, this.msg, this.token});

  LoginModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    email = json['email'];
    msg = json['msg'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['email'] = this.email;
    data['msg'] = this.msg;
    data['token'] = this.token;
    return data;
  }
}

class CheckUpdateModel {
  int code;
  String msg;
  String os;
  String versionName;
  int versionCode;
  int forceUpdate;
  String title;
  String updateDesc;
  String downloadUrl;

  CheckUpdateModel(
      {this.code,
        this.msg,
        this.os,
        this.versionName,
        this.versionCode,
        this.forceUpdate,
        this.title,
        this.updateDesc,
        this.downloadUrl});

  CheckUpdateModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    os = json['os'];
    versionName = json['versionName'];
    versionCode = json['versionCode'];
    forceUpdate = json['forceUpdate'];
    title = json['title'];
    updateDesc = json['updateDesc'];
    downloadUrl = json['downloadUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    data['os'] = this.os;
    data['versionName'] = this.versionName;
    data['versionCode'] = this.versionCode;
    data['forceUpdate'] = this.forceUpdate;
    data['title'] = this.title;
    data['updateDesc'] = this.updateDesc;
    data['downloadUrl'] = this.downloadUrl;
    return data;
  }
}

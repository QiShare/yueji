class HomeModel {
  int code;
  String msg;
  List<Banners> banners;

  HomeModel({this.code, this.msg, this.banners});

  HomeModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['banners'] != null) {
      banners = new List<Banners>();
      json['banners'].forEach((v) {
        banners.add(new Banners.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.banners != null) {
      data['banners'] = this.banners.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banners {
  Null title;
  String imgUrl;
  int type;

  Banners({this.title, this.imgUrl, this.type});

  Banners.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    imgUrl = json['imgUrl'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['imgUrl'] = this.imgUrl;
    data['type'] = this.type;
    return data;
  }
}

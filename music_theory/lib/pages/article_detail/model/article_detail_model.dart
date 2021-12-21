class ArticleDetailModel {
  int code;
  String msg;
  String articleDetail;

  ArticleDetailModel({this.code, this.msg, this.articleDetail});

  ArticleDetailModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    articleDetail = json['articleDetail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    data['articleDetail'] = this.articleDetail;
    return data;
  }
}

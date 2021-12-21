import 'package:music/net/base_model.dart';
import 'package:music/pages/about/model/check_update_model.dart';
import 'package:music/pages/article_detail/model/article_detail_model.dart';
import 'package:music/pages/home/model/article_list_model.dart';
import 'package:music/pages/home/model/home_model.dart';
import 'package:music/pages/login/model/login_model.dart';

import 'net_util.dart';

class ApiClient {
  /// 首页
  static Future<HomeModel> home() async {
    var result = await NetUtil.doGet("/home");
    return HomeModel.fromJson(result);
  }

  /// 乐理列表
  static Future<ArticleListModel> getArticleList(int page,
      {int pageSize = 10}) async {
    Map map = Map<String, dynamic>();
    map["page"] = page;
    map["pageSize"] = pageSize;
    var result = await NetUtil.doPost("/article", params: map);
    return ArticleListModel.fromJson(result);
  }

  /// 乐理详情
  static Future<ArticleDetailModel> getArticleDetail(int id) async {
    Map map = Map<String, dynamic>();
    map["id"] = id;
    var result = await NetUtil.doPost("/article/detail", params: map);
    return ArticleDetailModel.fromJson(result);
  }

  /// 发送验证码
  static Future<BaseModel> sendEmail(String email) async {
    Map map = Map<String, dynamic>();
    map["email"] = email;
    var result = await NetUtil.doPost("/auth/email/send", params: map);
    return BaseModel.fromJson(result);
  }

  /// 登录
  static Future<LoginModel> login(String email, String verifyCode) async {
    Map map = Map<String, dynamic>();
    map["email"] = email;
    map["verifyCode"] = verifyCode;
    var result = await NetUtil.doPost("/auth/login", params: map);
    return LoginModel.fromJson(result);
  }

  /// 意见反馈
  static Future<BaseModel> feedback(String content) async {
    Map map = Map<String, dynamic>();
    map["content"] = content;
    var result = await NetUtil.doPost("/feedback", params: map);
    return BaseModel.fromJson(result);
  }

  /// 检查更新
  static Future<CheckUpdateModel> checkUpdate() async {
    var result = await NetUtil.doPost("/check/update");
    return CheckUpdateModel.fromJson(result);
  }
}

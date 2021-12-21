import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music/manager/user_manager.dart';
import 'package:music/pages/about/view.dart';
import 'package:music/pages/feedback/view.dart';
import 'package:music/pages/setting/setting_page.dart';
import 'package:music/pages/user/component/user_item_widget.dart';

/// 我的
class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 350,
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xfffccbcb),
                      Color(0xfff9f9f9),
                    ],
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 60,
                    ),
                    Container(
                      width: 90,
                      height: 90,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/images/icon_launcher_round.png'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "${UserManager.instance.userModel.email ?? ""}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                transform: Matrix4.translationValues(0, -50, 0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xfff5f5f5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    UserItemWidget(
                      text: "反馈",
                      icon: Image.asset(
                        "assets/images/icon_feedback.png",
                        width: 20,
                        height: 20,
                        color: Colors.grey,
                      ),
                      onTap: () => Get.to(FeedbackPage()),
                    ),
                    UserItemWidget(
                      text: "设置",
                      icon: Image.asset(
                        "assets/images/icon_setting.png",
                        width: 20,
                        height: 20,
                        color: Colors.grey,
                      ),
                      onTap: () => Get.to(SettingPage()),
                    ),
                    UserItemWidget(
                      text: "关于",
                      icon: Image.asset(
                        "assets/images/icon_about.png",
                        width: 20,
                        height: 20,
                        color: Colors.grey,
                      ),
                      onTap: () => Get.to(AboutPage()),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

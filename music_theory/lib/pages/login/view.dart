import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music/pages/login/state.dart';
import 'package:music/utils/color_utils.dart';

import 'logic.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String email = Get.arguments;
    final LoginLogic logic = Get.put(LoginLogic(email));
    final LoginState state = Get.find<LoginLogic>().state;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      size: 40,
                    ),
                    onPressed: () => Get.back(),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 60,
            ),
            _buildLogoWidget(),
            SizedBox(
              height: 60,
            ),
            Text(
              "验证码已发送至邮箱$email",
              style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.grey[600],
                letterSpacing: 2,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              margin: const EdgeInsets.only(right: 30, left: 30),
              child: TextField(
                controller: state.codeController,
                maxLength: 4,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  letterSpacing: 1,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: "请输入验证码",
                  counterText: "",
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    letterSpacing: 1,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              height: 50,
              margin: const EdgeInsets.only(right: 30, left: 30),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                elevation: 0,
                color: Theme.of(context).primaryColor,
                onPressed: () => logic.login(),
                child: Text(
                  "登录",
                  style: TextStyle(
                    color: ColorUtils.white,
                    fontSize: 16,
                    letterSpacing: 5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildLogoWidget() {
    return Container(
      width: 80,
      height: 80,
      child: Image.asset(
        "assets/images/icon_launcher.png",
        fit: BoxFit.cover,
      ),
    );
  }
}

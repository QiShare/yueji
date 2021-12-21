import 'package:flutter/material.dart';
import 'package:music/utils/color_utils.dart';

/// 用户页面 item
class UserItemWidget extends StatelessWidget {
  final String text;
  final Widget icon;
  final VoidCallback onTap;

  const UserItemWidget({Key key, this.onTap, this.text, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 10,
            ),
            Container(
              width: 38,
              height: 38,
              child: Center(child: icon),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: TextStyle(
                color: ColorUtils.dark_blue,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

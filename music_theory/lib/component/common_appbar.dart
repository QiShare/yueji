import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final List<Widget> actions;
  final Widget leading;
  final Color backgroundColor;
  final bool centerTitle;
  final double elevation;

  const CommonAppBar({
    Key key,
    this.title,
    this.actions,
    this.leading,
    this.backgroundColor = Colors.white,
    this.centerTitle = true,
    this.elevation = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      backgroundColor: backgroundColor,
      elevation: elevation,
      leading: leading ??
          IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => Get.back(),
          ),
      title: title,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}

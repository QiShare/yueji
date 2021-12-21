import 'package:flutter/material.dart';

class CustomDialog {
  static Future<T> showCustomDialog<T>(
    BuildContext context, {
    BorderRadiusGeometry borderRadius =
        const BorderRadius.all(Radius.circular(8.0)),
    Widget title,
    Widget content,
    @required Widget negativeText,
    @required Widget positiveText,
    VoidCallback onNegativePressed,
    VoidCallback onPositivePressed,
  }) {
    return showDialog<T>(
        context: context,
        builder: (context) {
          return SimpleDialog(
            shape: RoundedRectangleBorder(borderRadius: borderRadius),
            title: DefaultTextStyle(
              style: TextStyle(color: const Color(0xff414141), fontSize: 18),
              textAlign: TextAlign.center,
              child: title,
            ),
            backgroundColor: Colors.white,
            contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            children: <Widget>[
              (content != null)
                  ? Padding(
                      padding: EdgeInsets.fromLTRB(24, 20, 24, 24),
                      child: DefaultTextStyle(
                        textAlign: TextAlign.center,
                        child: content,
                        style: TextStyle(
                            color: const Color(0xff414141), fontSize: 14),
                      ),
                    )
                  : SizedBox(
                      height: 20,
                    ),
              Divider(
                color: const Color(0xfff1f1f1),
                height: 0.5,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                          height: 56,
                          child: FlatButton(
                            child: DefaultTextStyle(
                              child: negativeText,
                              style: TextStyle(
                                  color: const Color(0xff414141), fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                            onPressed: onNegativePressed,
                          )),
                    ),
                    Container(
                      width: 0.5,
                      height: 56,
                      color: const Color(0xfff1f1f1),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                          height: 56,
                          child: FlatButton(
                            child: DefaultTextStyle(
                              child: positiveText,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                            onPressed: onPositivePressed,
                          )),
                    ),
                  ]),
            ],
          );
        });
  }

  static Future<T> showConfirmDialog<T>(
    BuildContext context, {
    BorderRadiusGeometry borderRadius =
        const BorderRadius.all(Radius.circular(8.0)),
    Widget title,
    Widget content,
    Widget neutralText = const Text(""),
    VoidCallback onNeutralPressed,
  }) {
    return showDialog<T>(
        context: context,
        builder: (context) {
          return SimpleDialog(
            shape: RoundedRectangleBorder(borderRadius: borderRadius),
            title: DefaultTextStyle(
              style: TextStyle(color: const Color(0xff414141), fontSize: 16),
              textAlign: TextAlign.center,
              child: title,
            ),
            titlePadding: EdgeInsets.fromLTRB(10, 24, 10, 10),
            backgroundColor: Colors.white,
            contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            children: <Widget>[
              (content != null)
                  ? Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 24, 24),
                      child: DefaultTextStyle(
                        child: content,
                        style: TextStyle(
                            color: const Color(0xff414141), fontSize: 16),
                      ),
                    )
                  : SizedBox(
                      height: 20,
                    ),
              Divider(
                color: Color(0xffcccccc),
                height: 0.5,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                          height: 56,
                          child: FlatButton(
                            child: DefaultTextStyle(
                              child: neutralText,
                              style: TextStyle(
                                  color: const Color(0xff414141), fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                            onPressed: onNeutralPressed,
                          )),
                    ),
                  ]),
            ],
          );
        });
  }
}

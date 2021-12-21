import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music/component/common_appbar.dart';
import 'package:music/utils/color_utils.dart';

import 'logic.dart';
import 'state.dart';

class FeedbackPage extends StatelessWidget {
  static final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(1),
    borderSide: BorderSide(
      width: 0.5,
      color: Color(0xffe2e2e2),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final FeedbackLogic logic = Get.put(FeedbackLogic());
    final FeedbackState state = Get.find<FeedbackLogic>().state;

    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: CommonAppBar(
        title: Text(
          "意见反馈",
          style: TextStyle(
            color: ColorUtils.dark_blue,
            fontSize: 16,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: state.textController,
                  autofocus: false,
                  textAlign: TextAlign.left,
                  minLines: 10,
                  maxLines: 10,
                  style: TextStyle(fontSize: 11),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: state.hint,
                    counterText: "",
                    hintStyle: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  margin: const EdgeInsets.only(top: 20),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    elevation: 0,
                    color: Theme.of(context).primaryColor,
                    onPressed: () => logic.submit(),
                    child: Text(
                      "提交",
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
        ),
      ),
    );
  }
}

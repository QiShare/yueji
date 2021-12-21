import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef CommonPickerChanged = void Function(int index, int index2, int index3);

class CommonPicker extends StatefulWidget {
  final List<String> data;
  final List<String> secondData;
  final List<String> thirdData;
  final CommonPickerChanged onSelected;

  const CommonPicker({
    Key key,
    @required this.data,
    this.secondData,
    this.thirdData,
    @required this.onSelected,
  }) : super(key: key);

  @override
  _CommonPickerState createState() => _CommonPickerState();
}

class _CommonPickerState extends State<CommonPicker> {
  int _selectedIndex = 0;
  int _selected2Index = 0;
  int _selected3Index = 0;

  /// 滚轮数量，默认一个
  int _count = 1;

  @override
  void initState() {
    super.initState();
    if (widget.secondData != null) {
      _count++;
    }
    if (widget.thirdData != null) {
      _count++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                onPressed: () => Get.back(),
                child: Text(
                  "取消",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  widget?.onSelected
                      ?.call(_selectedIndex, _selected2Index, _selected3Index);
                  Get.back();
                },
                child: Text(
                  "确认",
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 300,
            width: Get.width,
            child: Row(
              children: <Widget>[
                Container(
                  width: Get.width / _count,
                  child: CupertinoPicker(
                    itemExtent: 44,
                    onSelectedItemChanged: (value) {
                      _selectedIndex = value;
                    },
                    children: widget.data.map((data) {
                      return Container(
                        alignment: Alignment.center,
                        child: Text(
                          data,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Offstage(
                  offstage: widget.secondData == null,
                  child: Container(
                    width: Get.width / _count,
                    child: CupertinoPicker(
                      itemExtent: 44,
                      onSelectedItemChanged: (value) {
                        _selected2Index = value;
                      },
                      children: widget.secondData == null
                          ? []
                          : widget.secondData.map((data) {
                              return Container(
                                alignment: Alignment.center,
                                child: Text(
                                  data,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              );
                            }).toList(),
                    ),
                  ),
                ),
                Offstage(
                  offstage: widget.thirdData == null,
                  child: Container(
                    width: Get.width / _count,
                    child: CupertinoPicker(
                      itemExtent: 44,
                      onSelectedItemChanged: (value) {
                        _selected3Index = value;
                      },
                      children: widget.thirdData == null
                          ? []
                          : widget.thirdData.map((data) {
                              return Container(
                                alignment: Alignment.center,
                                child: Text(
                                  data,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              );
                            }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

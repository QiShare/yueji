import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:music/pages/home/view.dart';
import 'package:music/pages/metronome/metronome_page.dart';
import 'package:music/pages/send_email/view.dart';
import 'package:music/pages/user/user_page.dart';
import 'package:music/utils/color_utils.dart';

import 'event/event_bus.dart';
import 'manager/user_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await UserManager.instance.init();

  runApp(MyApp());

  /// 设置状态栏透明
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..radius = 8
    ..indicatorSize = 25
    ..userInteractions = false
    ..backgroundColor = Colors.white
    ..indicatorColor = ColorUtils.primary
    ..maskType = EasyLoadingMaskType.none
    ..textColor = ColorUtils.primary
    ..backgroundColor = ColorUtils.dark_blue
    ..contentPadding = const EdgeInsets.symmetric(
      vertical: 10.0,
      horizontal: 15.0,
    )
    ..indicatorType = EasyLoadingIndicatorType.threeBounce;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: ColorUtils.primary,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainPage(),
      builder: EasyLoading.init(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final List<Widget> _pageList = [
    KeepAliveWrapper(child: HomePage()),
    KeepAliveWrapper(child: MetronomePage()),
    KeepAliveWrapper(child: UserPage()),
  ];

  List<BottomNavigationBarItem> _barItem;

  PageController _pageController;

  @override
  void initState() {
    super.initState();
    GlobalEvent.eventBus.on<LogoutEvent>().listen((event) {
      setState(() {
        _currentIndex = 0;
        _pageController.jumpToPage(_currentIndex);
      });
    });

    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    _barItem = [
      BottomNavigationBarItem(
        icon: SizedBox(
          width: 22,
          height: 22,
          child: Image.asset(
            "assets/images/icon_note.png",
            color: ColorUtils.dark_blue,
          ),
        ),
        activeIcon: SizedBox(
          width: 22,
          height: 22,
          child: Image.asset(
            "assets/images/icon_note.png",
            color: ColorUtils.primary,
          ),
        ),
        label: "乐理",
      ),
      BottomNavigationBarItem(
        icon: SizedBox(
          width: 22,
          height: 22,
          child: Image.asset(
            "assets/images/icon_beat.png",
            color: ColorUtils.dark_blue,
          ),
        ),
        activeIcon: SizedBox(
          width: 22,
          height: 22,
          child: Image.asset(
            "assets/images/icon_beat.png",
            color: ColorUtils.primary,
          ),
        ),
        label: "节拍器",
      ),
      BottomNavigationBarItem(
        icon: SizedBox(
          width: 22,
          height: 22,
          child: Image.asset(
            "assets/images/icon_user.png",
            color: ColorUtils.dark_blue,
          ),
        ),
        activeIcon: SizedBox(
          width: 22,
          height: 22,
          child: Image.asset(
            "assets/images/icon_user.png",
            color: ColorUtils.primary,
          ),
        ),
        label: "我的",
      ),
    ];

    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: _pageList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            if (index > 1) {
              if (!UserManager.instance.isLogin()) {
                Get.to(SendEmailPage());
                return;
              }
            }
            _currentIndex = index;
            _pageController.jumpToPage(_currentIndex);
          });
        },
        currentIndex: _currentIndex,
        items: _barItem,
        fixedColor: Theme.of(context).primaryColor,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        selectedLabelStyle: TextStyle(
          color: ColorUtils.primary,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(
          color: ColorUtils.dark_blue,
          fontWeight: FontWeight.bold,
        ),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

class KeepAliveWrapper extends StatefulWidget {
  final Widget child;

  const KeepAliveWrapper({Key key, this.child}) : super(key: key);

  @override
  __KeepAliveWrapperState createState() => __KeepAliveWrapperState();
}

class __KeepAliveWrapperState extends State<KeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}

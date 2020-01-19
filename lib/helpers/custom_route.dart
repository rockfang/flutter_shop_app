import 'package:flutter/material.dart';

///创建自动以路由类
class CustomRoute<T> extends MaterialPageRoute<T> {
  //1. 编写构造方法并调用父类构造方法
  CustomRoute({WidgetBuilder builder, RouteSettings setting})
      : super(builder: builder, settings: setting);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) {
      return child;
    }
    //2. 编写自定义动画
    //return super.buildTransitions(context, animation, secondaryAnimation, child);
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}

class CustomPageTransitionBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    if (route.settings.isInitialRoute) {
      return child;
    }
    //2. 编写自定义动画
    //return super.buildTransitions(context, animation, secondaryAnimation, child);
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}

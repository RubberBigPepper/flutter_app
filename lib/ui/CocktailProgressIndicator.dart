import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';

//класс анимированного прогресса загрузки коктейлей
class CocktailProgressIndicator extends StatefulWidget {
  @override
  _CocktailProgressIndicator createState() => _CocktailProgressIndicator();
}

class RoundClipPath extends CustomClipper<Path> {
  //клип по кругу

  RoundClipPath(double angle) {
    this.angle = angle;
  }
  //var radius=10.0;
  var angle = 0.0;
  @override
  Path getClip(Size size) {
    var centerX = size.width * 0.5;
    var centerY = size.height * 0.5;
    Path path = Path(); //делаем вырез пирога
    path.moveTo(centerX, centerY); //точка в центр
    path.lineTo(centerX, 0); //идем вверх
    path.arcTo(Rect.fromLTWH(0.0, 0.0, size.width, size.height), -0.5 * pi,
        angle, true);
    //addArc(Rect.fromLTWH(0.0, 0.0, size.width, size.height), -0.5 * pi, angle);
    path.lineTo(centerX, centerY); //точка в центр
    // print(angle);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

//сама реализация виджета
class _CocktailProgressIndicator extends State<CocktailProgressIndicator>
    with SingleTickerProviderStateMixin {
  //*-----определяем Animation и AnimationController-----*
  AnimationController _controller;
  Animation _myAnimation;

  void animationListener() {
    setState(() {});
  }

  //*-----запускаем Animation и AnimationController-----*
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _myAnimation = Tween<double>(
            //мы будем линейно изменять угол от 0 до двух Пи
            begin: 0.0,
            end: pi * 2.0)
        .animate(_controller);
    _myAnimation.addListener(animationListener);
    _controller.repeat();
  }

  @override
  void dispose() {
    _myAnimation.removeListener(animationListener);
    //-disposing the animation controller-
    _controller.reset();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
        child: Image.asset('images/glass.png', fit: BoxFit.contain),
        clipper: RoundClipPath(_myAnimation.value));
  }
}

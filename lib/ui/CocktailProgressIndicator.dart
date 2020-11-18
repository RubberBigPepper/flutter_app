import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';

//класс анимированного прогресса загрузки коктейлей
class CocktailProgressIndicator extends StatefulWidget {
  @override
  _CocktailProgressIndicator createState() => _CocktailProgressIndicator();
}

class RoundClipPath extends CustomClipper<Path> {//клип по кругу

  RoundClipPath(double angle){
    this.angle=angle;
  }
  //var radius=10.0;
  var angle = 0.0;
  @override
  Path getClip(Size size) {
    var centerX=size.width*0.5;
    var centerY=size.height*0.5;
    Path path = Path();//делаем вырез пирога
    path.moveTo(centerX, centerY);//точка в центр
    path.lineTo(centerX,0);//идем вверх
    path.addArc(Rect.fromLTWH(0.0, 0.0, size.width, size.height), 0.0, angle);
    path.lineTo(centerX, centerY);//точка в центр
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

//сама реализация виджета
class _CocktailProgressIndicator extends State<CocktailProgressIndicator> with SingleTickerProviderStateMixin {

  //*-----определяем Animation и AnimationController-----*
  AnimationController _controller;
  Animation _myAnimation;

  //*-----запускаем Animation и AnimationController-----*
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),

    );
    _myAnimation =
        Tween<double>( //мы будем линейно изменять угол от 0 до двух Пи
            begin: 0.0,
            end: pi * 2.0
        ).animate(
            CurvedAnimation(parent: _controller, curve: Curves.linear)
        );

    _controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _controller.repeat();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    //-disposing the animation controller-
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
        child: null,
        clipper: RoundClipPath(0.0)
    );
  }

}
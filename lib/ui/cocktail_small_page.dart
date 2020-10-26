//класс для виджета маленькой карточки коктейля при поиске
import 'package:flutter/material.dart';
import 'package:flutter_app/models/models.dart';

class CocktailSmallPage extends StatelessWidget {
  CocktailSmallPage(this.cocktail, {
    Key key,
  }) : super(key: key);

  final Cocktail cocktail;
  final width = 170.0;
  final height = 215.0;

  final backColor = Colors.greenAccent; //основной цвет фона
  final backColorFrame = Color.fromARGB(255, 21, 21, 28); //цвет фона рамки (закругленной)

  final titleFontSize = 14.0;
  final idFontSize = 10.0;

  final textColor = Colors.white;
  final textMargin = 16.0;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: this.width,
        height: this.height,
        color: backColor,
        constraints: BoxConstraints.tightFor(width: width,height: height),
        child: Stack(
          children: [
            getImageWidget(this.cocktail.drinkThumbUrl),
            //это картинка коктейля
            getCocktailDescription(),
            //описание коктейля
          ],
        ),
    );
  }

  Widget getImageWidget(String url) {
    return Image.network(
      url,
      height: this.height,
      width: this.width,
      fit: BoxFit.scaleDown,
    );
  }

  Widget generateText(String text, double fontSize, TextAlign align, double leftRightMargin) {
    return Container(
        margin: EdgeInsets.only(left: leftRightMargin, right: leftRightMargin, top: 6.0, bottom: 6.0),
        child: Text(
          text,
          textAlign: align,
          style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              decoration: TextDecoration.none
          ),
        ));
  }

  Widget textInOvalFrame(String text, double fontSize, double leftMargin) {
    //текст в овальной рамке
    return new Container(
      margin: EdgeInsets.only(left: 14.0),
      child: generateText(text, fontSize, TextAlign.left, leftMargin),
      decoration: new BoxDecoration(borderRadius: new BorderRadius.all(new Radius.circular(30.0)), color: this.backColorFrame),
    );
  }

  Widget getCocktailDescription() {
    //описание коктейля
    return SizedBox.expand(child:
      Align(
        alignment: Alignment.bottomLeft,
        child:
          Container(
          width: width,
          padding: EdgeInsets.only(
              bottom: 16.0),
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             // Expanded(child: Container(width: 0, height: 0)),
              generateText(this.cocktail.name, idFontSize, TextAlign.left, textMargin),
              textInOvalFrame("id: "+this.cocktail.id, idFontSize, textMargin),
            ],
          ),
        ),
      ),
    );
  }
}
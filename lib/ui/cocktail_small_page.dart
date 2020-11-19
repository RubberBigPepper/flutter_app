//класс для виджета маленькой карточки коктейля при поиске
import 'package:flutter/material.dart';
import 'package:flutter_app/models/models.dart';
import 'package:flutter_app/models/src/model/cocktail_definition.dart';

import 'CocktailProgressIndicator.dart';

class CocktailSmallPage extends StatelessWidget {
  CocktailSmallPage(
    this.cocktail, {
    Key key,
  }) : super(key: key);

  final CocktailDefinition cocktail;
  final width = 170.0;
  final height = 215.0;

  final backColor = Color.fromRGBO(14, 13, 19, 1); //основной цвет фона
  final backColorFrame = Color.fromARGB(255, 21, 21, 28); //цвет фона рамки (закругленной)

  final titleFontSize = 14.0;
  final idFontSize = 10.0;

  final textColor = Colors.white;
  final textMargin = 16.0;

  @override
  Widget build(BuildContext context) {
    return Container(
        //width: this.width,
        //height: this.height,
        //padding: EdgeInsets.all(10.0),
        // constraints: BoxConstraints.tightFor(width: width, height: height),
        child: ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: Stack(
        children: [
          getImageWidget(this.cocktail.drinkThumbUrl),
          //это картинка коктейля
          getCocktailDescription(),
          //описание коктейля
        ],
      ),
    ));
  }

  Widget getImageWidget(String url) {
    return Image.network(url, fit: BoxFit.contain, loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
      if (loadingProgress == null) return child;
      return Center(
          child: CocktailProgressIndicator());
          /*CircularProgressIndicator(
        value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes : null,
      ));*/
    });
  }

  Widget generateText(String text, double fontSize, TextAlign align, double leftRightMargin) {
    return Container(
        margin: EdgeInsets.only(left: leftRightMargin, right: leftRightMargin, top: 6.0, bottom: 6.0),
        child: Text(
          text,
          textAlign: align,
          style: TextStyle(color: textColor, fontSize: fontSize, decoration: TextDecoration.none),
        ));
  }

  Widget textInOvalFrame(String text, double fontSize, double leftMargin) {
    //текст в овальной рамке
    return Container(
      margin: EdgeInsets.only(left: 14.0),
      child: generateText(text, fontSize, TextAlign.left, leftMargin),
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30.0)), color: this.backColorFrame),
    );
  }

  Widget getCocktailDescription() {
    //описание коктейля
    return SizedBox.expand(
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(bottom: 16.0),
          decoration: BoxDecoration(
            gradient:
                LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color.fromRGBO(14, 13, 19, 0), Color.fromRGBO(14, 13, 19, 1)]),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Expanded(child: Container(width: 0, height: 0)),
              generateText(this.cocktail.name, idFontSize, TextAlign.left, textMargin),
              textInOvalFrame("id: " + this.cocktail.id, idFontSize, textMargin),
            ],
          ),
        ),
      ),
    );
  }
}

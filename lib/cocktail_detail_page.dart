import 'package:flutter/material.dart';
import 'package:flutter_app/models/models.dart';

class CocktailDetailPage extends StatelessWidget {
   CocktailDetailPage(
    this.cocktail, {
    Key key,
      }) : super(key: key);

  final Cocktail cocktail;
  final backColor = Colors.black;
  final backColorSec = Color.fromARGB(255, 26, 25, 39);

  final mainTitleFontSize=20.0;
  final titleFontSize=15.0;
  final descriptionFontSize=10.0;

  final textColor = Colors.white;
  final textMargin = 5.0;
  final textLeftMargin = 20.0;

  var screenWidth = 0.0;

  @override
  Widget build(BuildContext context) {
    /// TODO: Сделать верстку экрана "Карточка коктейля" по модели Cocktail cocktail
    /// Ссылка на макет
    /// https://www.figma.com/file/d2JJUBFu7Dg0HOV30XG7Z4/OTUS-FLUTTER.-%D0%A3%D1%80%D0%BE%D0%BA-3-%D0%94%D0%97?node-id=20%3A590
    ///для того что бы весь контент поместился, необходимо использовать SingleChildScrollView()
    ///
    ///
    final screenHeight = MediaQuery.of(context).size.height;
    this.screenWidth = MediaQuery.of(context).size.width;
    return Container(
        width: screenWidth,
        height: screenHeight,
        child:SingleChildScrollView(
          child: Column(
            //overflow: Overflow.visible,
            children: [
              getImageWidget(screenHeight, this.cocktail.drinkThumbUrl),//это картинка коктейля
              getCocktailDescription(),//описание коктейля
              getIngridientsWidget(),//описание ингридиентов
              getInstructionWidget(),//виджет приготовления
              getStarsWidget(),//звездочки
            ],
          ),
      ),
    );
  }

  Widget getImageWidget(double screenHeight, String url){
    return  Container(
        width: screenWidth,
        decoration: BoxDecoration(
        color: backColor,
        ),
        child: Image.network(
          url,
          height: (screenHeight / 3) + 56,
          fit: BoxFit.cover,
        )
    );
  }

  Widget generateText(String text, double fontSize, TextAlign align, double leftMargin){
    return Container(
        margin: EdgeInsets.only(left: leftMargin, right: textMargin, top: textMargin, bottom: textMargin),
        child:
          Text(text, textAlign: align, style: TextStyle(color: textColor, fontSize: fontSize),
        )
    );
  }

   Widget getCocktailDescription() {//описание коктейля
    return Container(
      width: screenWidth,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: backColorSec,
          ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          generateText(this.cocktail.name, mainTitleFontSize, TextAlign.left, textMargin),
          generateText("id: " + this.cocktail.id, descriptionFontSize, TextAlign.left, textLeftMargin),
          generateText('Категория коктейля:', titleFontSize, TextAlign.left, textMargin),
          generateText(this.cocktail.category.name, descriptionFontSize, TextAlign.left, textLeftMargin),
          generateText('Тип коктейля:', titleFontSize, TextAlign.left, textMargin),
          generateText(this.cocktail.cocktailType.name, descriptionFontSize, TextAlign.left, textLeftMargin),
          generateText('Тип стекла:', titleFontSize, TextAlign.left, textMargin),
          generateText(this.cocktail.glassType.name, descriptionFontSize, TextAlign.left, textLeftMargin),
        ],
      ),
    );
  }

   Widget getStarsWidget(){//линейка звездочек
      return Container(
          width: screenWidth,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
        color: backColor,
       ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.star, color: Colors.white),
              Icon(Icons.star, color: Colors.white),
              Icon(Icons.star, color: Colors.white),
              Icon(Icons.star, color: backColorSec),
              Icon(Icons.star, color: backColorSec),
            ],
        )

      );
   }

   List<Widget> getIngridientList() {
     //виджет для списка ингридиентов
     List<Widget> res = [];
     res.add(generateText(
         "Ингредиенты:", mainTitleFontSize, TextAlign.center, textMargin));
     for (IngredientDefinition ingredient in this.cocktail.ingredients) {
       res.add(Container(
           width: screenWidth,
            child: Row( //а это виджет одного ингридиента
              mainAxisAlignment: MainAxisAlignment.center,
             mainAxisSize: MainAxisSize.max,
             children: [
               Expanded(child: generateText(ingredient.ingredientName,
                titleFontSize, TextAlign.left,textMargin),
               ),
               generateText(
                   ingredient.measure, titleFontSize, TextAlign.right, textMargin),
             ],
           )
         )
       );
     }
     return res;
   }

   Widget getIngridientsWidget(){//виджет списка ингридиентов
     return Container(
       width: screenWidth,
       padding: const EdgeInsets.all(16.0),
       decoration: BoxDecoration(
         color: backColor,
       ),
       child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
         children: getIngridientList(),
       ),
     );
   }

   Widget getInstructionWidget(){//виджет приготовления
     return Container(
       width: screenWidth,
       padding: const EdgeInsets.all(16.0),
       decoration: BoxDecoration(
         color: backColorSec,
       ),
       child: Column(
         mainAxisSize: MainAxisSize.min,
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.stretch,
         children: [
           generateText("Инструкция по приготовлению:", mainTitleFontSize, TextAlign.center, textMargin),
           generateText(this.cocktail.instruction, titleFontSize, TextAlign.left, textMargin),
         ],
       ),
     );
   }
}

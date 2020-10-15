import 'package:flutter/material.dart';
import 'package:flutter_app/models/models.dart';

// MARK: Что нужно исправить.
//1. Для форматирования кода использовать dartfmt
//2. удалить ненужные this
//3. Исправить тестовые стили
//4. Сделать rating bar в соответствии с макетом
//5. Сделать обводку для значений в разделах Категория коктейля,Тип коктейля,Тип стекла
//6. Добавить иконку избранное (сердечко). Согласно макету

class CocktailDetailPage extends StatelessWidget {
  CocktailDetailPage(
      this.cocktail, {
        Key key,
      }) : super(key: key);

  final Cocktail cocktail;
  final backColor = Colors.black;
  final backColorSec = Color.fromARGB(255, 26, 25, 39);

  final mainTitleFontSize = 20.0;
  final titleFontSize = 15.0;
  final descriptionFontSize = 10.0;

  final textColor = Colors.white;
  final textMargin = 5.0;
  final textLeftMargin = 20.0;

  // MARK: CocktailDetailPage наследуется от  StatelessWidget. StatelessWidget должен быть immutable. Т.е все переменные должны быть final.
  // Подробнее тут.
  // https://dart.dev/tools/diagnostic-messages#must_be_immutable
  var screenWidth = 0.0;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // MARK: this. указывать не обязательно.
    // про this можно почитать тут https://dart-lang.github.io/linter/lints/unnecessary_this.html
    this.screenWidth = MediaQuery.of(context).size.width;

    // MARK: Не обязательно указывать для Container width и height. В данном случае он итак займет все свободное пространство
    return Container(
      width: screenWidth,
      height: screenHeight,
      child: SingleChildScrollView(
        child: Column(
          //overflow: Overflow.visible,
          children: [
            // MARK: this. указывать не обязательно.
            getImageWidget(screenHeight,
                // MARK: this не нужен
                this.cocktail.drinkThumbUrl), //это картинка коктейля
            getCocktailDescription(), //описание коктейля
            getIngridientsWidget(), //описание ингридиентов
            getInstructionWidget(), //виджет приготовления
            getStarsWidget(), //звездочки
          ],
        ),
      ),
    );
  }

  // MARK: если метод не будет использовать снаружи, то лучше сделать его приватным с помощью _ , т.е _getImageWidget
  Widget getImageWidget(double screenHeight, String url) {
    return Container(
        width: screenWidth,
        decoration: BoxDecoration(
          color: backColor,
        ),
        child: Image.network(
          url,
          height: (screenHeight / 3) + 56,
          fit: BoxFit.cover,
        ));
  }

  // MARK: Хороший метод который убирает лишнюю копипасту
  // Но его нужно улучшить. Т.к помимо fontSize у текста в макете есть различие
  // в fontWeight и height, Поэтому лучше в качестве параметра передавать TextStyle целиком
  // и завести final или const переменные с нужными нам значениями
  // например   static const _titleStyle = TextStyle(fontSize: 20,fontWeight: FontWeight.w500,height: 23/20);

  Widget generateText(
      String text, double fontSize, TextAlign align, double leftMargin) {
    return Container(
        margin: EdgeInsets.only(
            left: leftMargin,
            right: textMargin,
            top: textMargin,
            bottom: textMargin),
        child: Text(
          text,
          textAlign: align,
          style: TextStyle(color: textColor, fontSize: fontSize),
        ));
  }

  // MARK: У свойств коктейля используется обводка, ее нужно добавить.
  Widget getCocktailDescription() {
    //описание коктейля
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
          // MARK: this не нужен
          generateText(this.cocktail.name, mainTitleFontSize, TextAlign.left,
              textMargin),
          // MARK: this не нужен
          generateText("id: " + this.cocktail.id, descriptionFontSize,
              TextAlign.left, textLeftMargin),
          generateText(
              'Категория коктейля:', titleFontSize, TextAlign.left, textMargin),
          // MARK: this не нужен
          generateText(this.cocktail.category.name, descriptionFontSize,
              TextAlign.left, textLeftMargin),
          generateText(
              'Тип коктейля:', titleFontSize, TextAlign.left, textMargin),
          // MARK: this не нужен
          generateText(this.cocktail.cocktailType.name, descriptionFontSize,
              TextAlign.left, textLeftMargin),
          generateText(
              'Тип стекла:', titleFontSize, TextAlign.left, textMargin),
          // MARK: this не нужен
          generateText(this.cocktail.glassType.name, descriptionFontSize,
              TextAlign.left, textLeftMargin),
        ],
      ),
    );
  }

  // MARK: Несоответствует макету.
  // Что бы сделать обводку как в макте.
  // Можно использовать BoxDecoration(shape: BoxShape.circle,color: ...)
  //
  Widget getStarsWidget() {

    //линейка звездочек
    return Container(
        width: screenWidth,
        padding: const EdgeInsets.all(10.0),
        // MARK: Если нет никаких доп эффектов, скруглений, теней итд
        // то лучше просто Container(color:backColor) без BoxDecoration
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
        ));
  }

  List<Widget> getIngridientList() {
    //виджет для списка ингридиентов
    // MARK: лучше использовать var или final
    // https://dart-lang.github.io/linter/lints/omit_local_variable_types.html
    List<Widget> res = [];
    res.add(generateText(
        "Ингредиенты:", mainTitleFontSize, TextAlign.center, textMargin));
    // MARK: this не нужен
    for (IngredientDefinition ingredient in this.cocktail.ingredients) {
      res.add(Container(
        // MARK: screenWidth не нужно
          width: screenWidth,
          child: Row(
            //а это виджет одного ингридиента
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: generateText(ingredient.ingredientName, titleFontSize,
                    TextAlign.left, textMargin),
              ),
              generateText(ingredient.measure, titleFontSize, TextAlign.right,
                  textMargin),
            ],
          )));
    }
    return res;
  }

  Widget getIngridientsWidget() {
    //виджет списка ингридиентов
    return Container(
      // MARK: screenWidth не нужно
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

  Widget getInstructionWidget() {
    //виджет приготовления
    return Container(
      // MARK: screenWidth не нужно
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
          generateText("Инструкция по приготовлению:", mainTitleFontSize,
              TextAlign.center, textMargin),
          // MARK: this не нужен
          generateText(this.cocktail.instruction, titleFontSize, TextAlign.left,
              textMargin),
        ],
      ),
    );
  }
}

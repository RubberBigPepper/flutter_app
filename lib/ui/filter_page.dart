
// TODO: Сделать экран Фильтр по категории
// Ссылка на макет: https://www.figma.com/file/Uzn5jHYiiFgacPCWNhwbc5/%D0%9A%D0%BE%D0%BA%D1%82%D0%B5%D0%B9%D0%BB%D0%B8-Copy?node-id=20%3A590

// 1. Фильты - это CocktailCategory, получить все значения можно через CocktailCategory.values
// 2. Поиск по фильтру делаем через AsyncCocktailRepository().fetchCocktailsByCocktailCategory(CocktailCategory)
// 3. Используем StreamBuilder/FutureBuilder
// 4. По нажатию на категорию на странице должны обновится список коктейлей. Выбранная категория подсвечивается как в дизайне. По умолчанию выбрана первая категория.
// 5. Поиск по названию пока что не делаем!
// 6. Должны отображаться ошибки и состояние загрузки.
// 7. Для скролла используем CustomScrollView
// 8. Делаем fork от репозитория и сдаем через PR
// 9. Помним про декомпозицию кода по методам и классам.


import 'package:flutter/material.dart';
import 'package:flutter_app/models/models.dart';
import 'package:flutter_app/ui/cocktail_small_page.dart';

class CocktailsFilterScreen extends StatelessWidget {
  final categories = CocktailCategory.values;
  @override
  Widget build(BuildContext context) {
    final cocktail = SyncCocktailRepository().getHomeworkCocktail();
    //return CocktailSmallPage(cocktail);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return  Container(
        width: screenHeight,
        height: screenHeight,
        child:
        Column(
        children: [
          getSearchWidget(),
          getFilterBar(),
          getGridResult(),
        ],
      )
    );
  }

  Widget getSearchWidget() {//виджет поиска
    return Container(
      width: 48,
      height: 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Color.fromRGBO(42, 41, 58, 1)),
      child: Icon(Icons.star, color: Colors.amber),
    );
  }

  Widget getFilterBar() {//виджет поиска
    return  SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
      children: getFilterList(),
      ),
    );
  }

  Widget generateText(String text, double fontSize, TextAlign align, double leftRightMargin) {
    return Container(
        margin: EdgeInsets.only(left: leftRightMargin, right: leftRightMargin, top: 14.0, bottom: 14.0),
        child: Text(
          text,
          textAlign: align,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
              decoration: TextDecoration.none
          ),
        ));
  }

  Widget textInOvalFrame(String text, double fontSize, double leftRightMargin) {
    //текст в овальной рамке
    return new Container(
      margin: EdgeInsets.only(left: 14.0),
      child: generateText(text, fontSize, TextAlign.left, leftRightMargin),
      decoration: new BoxDecoration(borderRadius: new BorderRadius.all(new Radius.circular(30.0)), color: Color.fromRGBO(41, 44, 44,  1)),
    );
  }

  List<Widget> getFilterList() {
    //виджет для списка ингридиентов
    List<Widget> res = [];
    for (CocktailCategory cat in this.categories) {
      res.add(
          textInOvalFrame(cat.name, 15.0, 10.0)
      );
    }
    return res;
  }

  Widget getGridResult() {
    //виджет грида
    final cocktail = SyncCocktailRepository().getHomeworkCocktail();
    return  Flexible(
        child: GridView.count(
            shrinkWrap: true,
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 2,
          // Generate 100 widgets that display their index in the List.
          children: List.generate(10, (index) {
        return Center(
          child:  CocktailSmallPage(cocktail)
        );
      })
        )
    );
  }
}
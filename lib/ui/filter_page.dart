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
import 'package:flutter_app/models/src/model/cocktail_definition.dart';
import 'package:flutter_app/models/src/repository/async_cocktail_repository.dart';
import 'package:flutter_app/ui/cocktail_small_page.dart';
import 'package:flutter/services.dart';

class CocktailsFilterScreen extends StatefulWidget {
  @override
  createState() => CocktailFilterScreenWidgetState();
}

class CocktailFilterScreenWidgetState extends State<CocktailsFilterScreen> {
  static const chipBackColor = Color.fromRGBO(41, 44, 44, 1);
  final categories = CocktailCategory.values;
  var category; //выбранная категория
  var searchStr = ""; //строка поиска
  Iterable<CocktailDefinition> cocktailSelected; //выбранные коктейли
  var state = 0; //режим работы, 0 - нормальная работа, показ фильтра, 1 - ожидание подгрузки, -1 ошибка //надо бы сделать Enum, но некогда разбираться

  void setFilteredCocktailList(Iterable<CocktailDefinition> iter) {
    setState(() {
      //установим список выбранных коктейлей и обновим галерею
      cocktailSelected = iter;
      state = 0;
    });
  }

  void setCategory(CocktailCategory newCat) {
    setState(() {
      state = 1;
      category = newCat;
      /*AsyncCocktailRepository()
          .fetchCocktailsByCocktailCategory(category)
          .then((value) => {setFilteredCocktailList(value)})
          .catchError((e) => {
                //отразим ошибку
                state = -1
              });*/
    });
  }

  void setSearchString(String newStr) {
    setState(() {
      searchStr = newStr;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cocktail = SyncCocktailRepository().getHomeworkCocktail();
    //return CocktailSmallPage(cocktail);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
        width: screenHeight,
        height: screenHeight,
        decoration: BoxDecoration(
          gradient:
              LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color.fromRGBO(26, 25, 39, 1), Color.fromRGBO(11, 11, 18, 1)]),
        ),
        child: Column(
          children: [
            getSearchWidget(context),
            getFilterBar(),
            generateBodyWidget(context),
          ],
        ));
  }

  Widget getSearchWidget(BuildContext context) {
    //виджет поиска
    return Container(
      height: 40.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 14.0, top: 25.0),
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.start, children: [
        GestureDetector(
          onTap: () => {}, //надо видимо весь бар сделать отдельным stateful widgetом
          child: Container(
            width: 20,
            height: 20,
            alignment: Alignment.center,
            child: Icon(Icons.search, color: Colors.white),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 11.69, right: 11.69),
            child: Material(
              color: Color.fromRGBO(41, 44, 44, 1),
              child: TextField(
                style: TextStyle(color: Colors.white, fontSize: 13, decoration: TextDecoration.none),
                decoration:
                    InputDecoration(border: InputBorder.none, hintText: 'Текст для поиска', hintStyle: TextStyle(color: Colors.blueGrey), labelText: searchStr),
                onSubmitted: (String value) async {
                  setSearchString(value);
                },
              ),
            ),
          ),
        ),
        Container(
          width: 20,
          height: 20,
          alignment: Alignment.center,
          child: Icon(Icons.close, color: Colors.white),
        ),
      ]),
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30.0)), color: Color.fromRGBO(41, 44, 44, 1)),
    );
  }

  Widget getFilterBar() {
    //виджет поиска
    return Container(
        margin: EdgeInsets.only(top: 16.0),
        height: 46.0,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: 8.0, right: 8.0),
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: getFilterList(),
          ),
        ));
  }

  Widget getChipWidget(CocktailCategory category, Color backColor) {
    return Material(
        color: Colors.transparent, // Color.fromRGBO(11, 11, 18, 1),
        child: ActionChip(
            /*avatar: CircleAvatar(
            backgroundColor: backColor,
            child: Text('AB'),
          ),*/
            label: Text(
              category.name,
              style: TextStyle(color: Colors.white, fontSize: 15.0, decoration: TextDecoration.none),
            ),
            backgroundColor: backColor,
            onPressed: () {
              setCategory(category);
            }));
  }

  List<Widget> getFilterList() {
    //виджет для списка ингридиентов
    List<Widget> res = [];
    for (CocktailCategory cat in categories) {
      res.add((category != null && cat == category) ? getChipWidget(cat, Color.fromRGBO(59, 57, 83, 1)) : getChipWidget(cat, chipBackColor));
      res.add(SizedBox(
        width: 8.0,
        height: 46.0,
      ));
    }
    return res;
  }

  Widget getGridResult(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    //виджет грида, можно было и Wrap сделать
    return Flexible(
        child: GridView(
            shrinkWrap: true,
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.
            //crossAxisCount: 2,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: (screenWidth / 170.0).round(),
              crossAxisSpacing: 3.0,
              mainAxisSpacing: 3.0,
            ),
            children: generateFilteredCoctailList()));
  }

  List<Widget> generateFilteredCoctailList() {
    var res = List<Widget>();
    if (cocktailSelected != null) {
      for (CocktailDefinition cocktail in cocktailSelected) {
        res.add(Center(child: CocktailSmallPage(cocktail)));
      }
    }
    return res;
  }

  Widget generateBodyWidget_old(BuildContext context) {
    switch (state) {
      case 1: //идет загрузка
        return Flexible(child: Center(child: Icon(Icons.cloud_download, color: Colors.white)));
      case 0:
        if (cocktailSelected != null) return getGridResult(context);
    }
    return Flexible(
        child: Center(
      child: Text(
        "Ошибка загрузки",
        style: TextStyle(color: Colors.white, fontSize: 15.0, decoration: TextDecoration.none),
      ),
    ));
  }

  Widget generateBodyWidget(BuildContext context) {
    return FutureBuilder(
        initialData: null,
        future: AsyncCocktailRepository().fetchCocktailsByCocktailCategory(category), //вот магия - вызов Futures
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //ну а здесь что именно происходит
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Flexible(
                  child: Center(
                child: CircularProgressIndicator(), // ну или Center(child: Icon(Icons.cloud_download, color: Colors.white))
              ));
            case ConnectionState.done:
              cocktailSelected = snapshot.data;
              if (cocktailSelected != null && cocktailSelected.isNotEmpty)
                return getGridResult(context); //строим грид
              else {
                return Flexible(
                    child: Center(
                  child: Text(
                    "Ошибка загрузки",
                    style: TextStyle(color: Colors.white, fontSize: 15.0, decoration: TextDecoration.none),
                  ),
                ));
              }
          }
        });
  }
}

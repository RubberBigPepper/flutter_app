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
  createState() => new CocktailFilterScreenWidgetState();
}

class CocktailFilterScreenWidgetState extends State<CocktailsFilterScreen> {
  static const chipBackColor = Color.fromRGBO(41, 44, 44, 1);
  final categories = CocktailCategory.values;
  var Category = null; //выбранная категория
  var SearchStr = ""; //строка поиска
  Iterable<CocktailDefinition> CocktailsSelected = null; //выбранные коктейли
  var state =
      0; //режим работы, 0 - нормальная работа, показ фильтра, 1 - ожидание подгрузки, -1 ошибка //надо бы сделать Enum, но некогда разбираться

  void setFilteredCocktailList(Iterable<CocktailDefinition> iter) {
    setState(() {
      //установим список выбранных коктейлей и обновим галерею
      CocktailsSelected = iter;
      state = 0;
    });
  }

  void setCategory(CocktailCategory newCat) {
    setState(() {
      state = 1;
      Category = newCat;
      AsyncCocktailRepository()
          .fetchCocktailsByCocktailCategory(Category)
          .then((value) => {setFilteredCocktailList(value)})
          .catchError((e) => {
                //отразим ошибку
                state = -1
              });
    });
  }

  void setSearchString(String newStr) {
    setState(() {
      SearchStr = newStr;
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
        color: Color.fromRGBO(11, 11, 18, 1),
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
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Текст для поиска',
                    hintStyle: TextStyle(color: Colors.blueGrey),
                    labelText: SearchStr),
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
      decoration: new BoxDecoration(
          borderRadius: new BorderRadius.all(new Radius.circular(30.0)), color: Color.fromRGBO(41, 44, 44, 1)),
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
        color: Color.fromRGBO(11, 11, 18, 1),
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
    for (CocktailCategory cat in this.categories) {
      res.add((Category != null && cat == Category)
          ? getChipWidget(cat, Color.fromRGBO(59, 57, 83, 1))
          : getChipWidget(cat, chipBackColor));
      res.add(SizedBox(
        width: 8.0,
        height: 46.0,
      ));
    }
    return res;
  }

  Widget getGridResult() {
    //виджет грида, можно было и Wrap сделать
    return Flexible(
        child: GridView.count(
            shrinkWrap: true,
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.
            crossAxisCount: 2,
            // Generate 100 widgets that display their index in the List.
            children: generateFilteredCoctailList()));
  }

  List<Widget> generateFilteredCoctailList() {
    var res = List<Widget>();
    if (this.CocktailsSelected != null) {
      for (CocktailDefinition cocktail in this.CocktailsSelected) {
        res.add(Center(child: CocktailSmallPage(cocktail)));
      }
    }
    return res;
  }

  Widget generateBodyWidget(BuildContext context) {
    switch (state) {
      case 1: //идет загрузка
        return Flexible(child: Center(child: Icon(Icons.cloud_download, color: Colors.white)));
      case 0:
        if (this.CocktailsSelected != null) return getGridResult();
    }
    return Flexible(
        child: Center(
      child: Text(
        "Ошибка загрузки",
        style: TextStyle(color: Colors.white, fontSize: 15.0, decoration: TextDecoration.none),
      ),
    ));
  }
}

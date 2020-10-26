import 'package:flutter/material.dart';
import 'package:flutter_app/ui/filter_page.dart';

import 'ui/cocktail_detail_page.dart';
import 'models/src/repository/async_cocktail_repository.dart';
import 'models/src/repository/sync_cocktail_repository.dart';

void main() {
  runApp(MyAppFilter()); //страничка о категориях коктейля
  //runApp(MyAppCocktailPage());//это страничка о коктейле (1 домашка)
}

class MyAppFilter extends StatelessWidget {//виджет фильтра по категориям
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showSemanticsDebugger: false,
      title: 'Filter demo',
      home: CocktailsFilterScreen(),
    );
  }
}

class MyAppCocktailPage extends StatelessWidget {//виджет странички коктейля
  @override
  Widget build(BuildContext context) {
    final cocktail = SyncCocktailRepository().getHomeworkCocktail();
    return MaterialApp(
      showSemanticsDebugger: false,
      title: 'Flutter Demo',
      home: Material(child: CocktailDetailPage(cocktail)),
    );
  }
}


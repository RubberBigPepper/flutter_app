import 'package:flutter/material.dart';

import 'cocktail_detail_page.dart';
import 'models/src/repository/async_cocktail_repository.dart';
import 'models/src/repository/sync_cocktail_repository.dart';

void main() {
  //final testIngredient = AsyncCocktailRepository().lookupIngredientById('552');
  final cocktail = SyncCocktailRepository().getHomeworkCocktail();
  runApp(MaterialApp(
    showSemanticsDebugger: false,
    title: 'Flutter Demo',
    home: Material(child: CocktailDetailPage(cocktail)),
  ));
}

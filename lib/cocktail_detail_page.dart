import 'package:flutter/material.dart';
import 'package:flutter_app/models/models.dart';

class CocktailDetailPage extends StatelessWidget {
  const CocktailDetailPage(
    this.cocktail, {
    Key key,
  }) : super(key: key);

  final Cocktail cocktail;

  @override
  Widget build(BuildContext context) {
    /// TODO: Сделать верстку экрана "Карточка коктейля" по модели Cocktail cocktail
    /// Ссылка на макет
    /// https://www.figma.com/file/d2JJUBFu7Dg0HOV30XG7Z4/OTUS-FLUTTER.-%D0%A3%D1%80%D0%BE%D0%BA-3-%D0%94%D0%97?node-id=20%3A590
    ///для того что бы весь контент поместился, необходимо использовать SingleChildScrollView()
    ///
    ///
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
        height: screenHeight,
        child:SingleChildScrollView(
          child: Stack(
            overflow: Overflow.visible,
            children: [
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Image.network(
                  'https://mircocktails.ru/wp-content/uploads/2019/02/Martini-Byanko-11-1.jpg',
                  height: (screenHeight / 2) + 56,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 0.0,
                left: 0.0,
                top: 200,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          top: 16, left: 16, right: 16, bottom: 56.0 + 16.0),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(56),
                              topLeft: Radius.circular(56))),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text('Text1', textAlign: TextAlign.center),
                          Text('Text1', textAlign: TextAlign.center),
                          Text('Text1', textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.green,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(56),
                                topLeft: Radius.circular(56))),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text('Text1', textAlign: TextAlign.center),
                            Text('Text1', textAlign: TextAlign.center),
                            Text('Text1', textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.red,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(56),
                                topLeft: Radius.circular(56))),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text('Text1', textAlign: TextAlign.center),
                            Text('Text1', textAlign: TextAlign.center),
                            Text('Text1', textAlign: TextAlign.center),
                            Text('Text1', textAlign: TextAlign.center),
                            Text('Text1', textAlign: TextAlign.center),
                            Text('Text1', textAlign: TextAlign.center),
                            Text('Text1', textAlign: TextAlign.center),
                            Text('Text1', textAlign: TextAlign.center),
                            Text('Text1', textAlign: TextAlign.center),
                            Text('Text1', textAlign: TextAlign.center),
                            Text('Text1', textAlign: TextAlign.center),
                            Text('Text1', textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }
}

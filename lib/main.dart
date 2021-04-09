import 'package:deli_meals/screens/categories_screen.dart';
import 'package:deli_meals/screens/category_meals_screen.dart';
import 'package:deli_meals/screens/meal_detail_screen.dart';
import 'package:deli_meals/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: THEME_DATA,
      // home: CategoriesScreen(),
      // initialRoute: '/',
      routes: {
        '/': (ctx) => CategoriesScreen(),
        CategoryMealsScreen.ROUTE_NAME: (ctx) => CategoryMealsScreen(),
        MealDetailScreen.ROUTE_NAME: (ctx) => MealDetailScreen(),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        /*
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
        */
      },
      onUnknownRoute: (settings) {
        print(settings.arguments);
        // 404
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}

import 'package:deli_meals/dummy_data.dart';
import 'package:deli_meals/models/meal.dart';
import 'package:deli_meals/screens/categories_screen.dart';
import 'package:deli_meals/screens/category_meals_screen.dart';
import 'package:deli_meals/screens/filters_screen.dart';
import 'package:deli_meals/screens/meal_detail_screen.dart';
import 'package:deli_meals/screens/tabs_screen.dart';
import 'package:deli_meals/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> favoriteMeals = [];

  Map<String, bool> _filters = {
    'gluten': false,
    'vegetarian': false,
    'vegan': false,
    'lactose': false,
  };

  void _setFilters(Map<String, bool> filtersData) {
    setState(() {
      _filters = filtersData;

      availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree) return false;
        if (_filters['vegetarian']! && !meal.isVegetarian) return false;
        if (_filters['vegan']! && !meal.isVegan) return false;
        if (_filters['lactose']! && !meal.isLactoseFree) return false;

        return true;
      }).toList();
    });
  }

  void _toogleFavorite(String mealId) {
    final existingIndex = favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isFavoriteMeal(String mealId) {
    return favoriteMeals.any((meal) => meal.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: THEME_DATA,
      // home: CategoriesScreen(),
      // initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(favoriteMeals),
        CategoryMealsScreen.ROUTE_NAME: (ctx) =>
            CategoryMealsScreen(availableMeals),
        MealDetailScreen.ROUTE_NAME: (ctx) =>
            MealDetailScreen(_toogleFavorite, _isFavoriteMeal),
        FiltersScreen.ROUTE_NAME: (ctx) => FiltersScreen(_filters, _setFilters),
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

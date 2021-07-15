import './screens/filters_screen.dart';

import './screens/tab_screen.dart';

import './screens/category_meals_screen.dart';
import './screens/meal_detail_screen.dart';
import 'package:flutter/material.dart';

import 'dummy_data.dart';
import 'models/meal.dart';
import 'screens/categories_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> filters = {
    'gluten': false,
    'vegan': false,
    'vegetarian': false,
    'lactose': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> favoriteMeals = [];

  void _toggleFavorite(String mealId) {
    int existingIndex = favoriteMeals.indexWhere((meal) => mealId == meal.id);
    if (existingIndex >= 0)
      setState(() {
        favoriteMeals.removeAt(existingIndex);
      });
    else
      setState(() {
        favoriteMeals.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
        );
      });
  }

  bool _isMealFavorite(String id) {
    return favoriteMeals.any((meal) => id == meal.id);
  }

  void _setFilter(Map<String, bool> filterData) {
    setState(() {
      filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (filters['gluten'] && !meal.isGlutenFree) return false;
        if (filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (filters['vegetarian'] && !meal.isVegetarian) return false;
        if (filters['lactose'] && !meal.isLactoseFree) return false;
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            body1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            body2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            title: TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
      ),
      routes: {
        '/': (context) => TabsScreen(_toggleFavorite, favoriteMeals),
        CategoryMealsScreen.routeName: (context) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (context) =>
            MealDetailScreen(_toggleFavorite, _isMealFavorite),
        FiltersScreen.routeName: (context) =>
            FiltersScreen(filters, _setFilter),
      },
    );
  }
}

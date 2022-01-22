import 'package:flutter/material.dart';
import 'package:mealsapp/models/dummy_data.dart';
import 'package:mealsapp/screens/categories_meals.dart';
import 'package:mealsapp/screens/categories_screen.dart';
import 'package:mealsapp/screens/filters_screen.dart';
import 'package:mealsapp/screens/meal_details.dart';
import 'package:mealsapp/screens/tabs_screen.dart';
import 'package:mealsapp/models/meals.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  Map<String, bool> _filters = {
    'guleten': false,
    'lactose': false,
    'vegan': false,
    'vegeterian': false,
  };

  void _toggleFavorites(String mealid) {
    int existingMealid = _favoriteMeals.indexWhere((meal) => meal.id == mealid);

    if (existingMealid >= 0) {
      _favoriteMeals.removeAt(existingMealid);
    } else {
      _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealid));
    }
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  void setFilters(Map<String, bool> currentFilter) {
    setState(() {
      _filters = currentFilter;
      availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['guleten']! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['vegeterian']! && !meal.isVegetarian) {
          return false;
        }
        if (_filters['vegan']! && !meal.isVegan) {
          return false;
        }
        if (_filters['lactose']! && !meal.isLactoseFree) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    setFilters(_filters);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'DeliMeals',
        theme: ThemeData(
          colorScheme: ColorScheme.light().copyWith(
            primary: Colors.pink,
            secondary: Colors.amber,
          ),
          primarySwatch: Colors.pink,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                caption: TextStyle(
                    fontSize: 20,
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold),
              ),
        ),
        home: TabsScreen(_favoriteMeals, _toggleFavorites),
        routes: {
          CategoryMeals.routeName: (ctx) {
            return CategoryMeals(availableMeals);
          },
          MealDetails.routeName: (ctx) {
            return MealDetails(_toggleFavorites, _isMealFavorite);
          },
          FiltersScreen.routeName: (ctx) {
            return FiltersScreen(
                current_filters: _filters, saveFilters: setFilters);
          }
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) {
              return CategoriesScreen();
            },
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mealapp/dummy_data.dart';
import 'package:mealapp/models/meal.dart';
import 'package:mealapp/screens/category_meal_screen.dart';
import 'package:mealapp/screens/filter_screen.dart';
import 'package:mealapp/screens/meal_detail_screen.dart';
import 'package:mealapp/screens/tabs_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String,bool> _filters ={
    'gluten':false,
    'vegan':false,
    'vegetarian':false,
    'lactose':false
  };
  List<Meal> _availableMeal = dummyMeals;
  List<Meal> _favouriteMeal = [];

  void _setFilters(Map<String,bool> filterData){
    setState(() {
      _filters = filterData;
      _availableMeal = dummyMeals.where((meal){
        if(_filters['gluten'] ==true && !meal.isGlutenFree){
            return false;
        }
        if(_filters['vegan'] ==true && !meal.isVegan){
        return false;
        }
        if(_filters['vegetarian'] ==true && !meal.isVegetarian){
          return false;
        }
        if(_filters['lactose'] ==true && !meal.isLactoseFree){
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavourite(String mealtitle){
    final existingIndex = _favouriteMeal.indexWhere((meal)=>meal.title==mealtitle);
    if(existingIndex>=0){
      setState(() {
        _favouriteMeal.removeAt(existingIndex);
        Fluttertoast.showToast(
            msg: 'Removed from Favourites',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.teal
        );
      });
    }else{
      setState(() {
        _favouriteMeal.add(dummyMeals.firstWhere((meal) => meal.title==mealtitle),);
        Fluttertoast.showToast(
            msg: 'Added to Favourites',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.teal
        );
      });
    }
  }


  bool _isMealFav(String title){
    return _favouriteMeal.any((meal) => meal.title==title);

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal Application',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(0,128,128,1),
        primaryColorLight: Color.fromRGBO(255, 255, 255, 1),
          //primaryColorDark: Color.fromRGBO(255, 0, 0, 1),
        accentColor: Colors.teal,
        canvasColor: const Color.fromRGBO(250, 250, 250, 1),
        fontFamily: 'Lato',
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal).copyWith(secondary: Color.fromRGBO(250, 0, 0, 1)),
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyText1: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
          bodyText2: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
          subtitle1: const TextStyle(fontSize: 20, fontFamily: 'Lato', fontWeight: FontWeight.w300)
        )
      ),

      // home: const ,
      initialRoute: '/', //default loading path
      routes: {
          '/' : (ctx) => TabsScreen(_favouriteMeal),
          CategoryMealScreen.routeName: (ctx) => CategoryMealScreen(_availableMeal),
        MealDetail.routeName: (ctx) => MealDetail(_toggleFavourite,_isMealFav),
        FilterScreen.routeName: (ctx) => FilterScreen(_setFilters,_filters),
      },
    );
  }
}


import 'package:flutter/material.dart';
import 'package:mealsapp/models/meals.dart';
import 'package:mealsapp/screens/categories_meals.dart';
import '../models/dummy_data.dart';

class MealDetails extends StatelessWidget {
  static const routeName = '/meals-details';
  final Function toggleFavorite;
  final Function isFavorite;

  MealDetails(this.toggleFavorite, this.isFavorite);
  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)?.settings.arguments as String;
    final mealDetails = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(title: Text('Meal details for ${mealDetails.title}')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                mealDetails.imageUrl,
                fit: BoxFit.contain,
              ),
            ),
            buildSectiontitle(context, 'Ingredients'),
            buildSectionList(context, mealDetails, 'Ingredients'),
            buildSectiontitle(context, 'Steps'),
            buildSectionList(context, mealDetails, 'Steps'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isFavorite(mealId) ? Icons.star : Icons.star_border,
        ),
        onPressed: () => toggleFavorite(mealId),
      ),
    );
  }
}

Widget buildSectionList(
    BuildContext context, Meal mealDetails, String whattobuild) {
  return Container(
    margin: EdgeInsets.all(10),
    height: 150,
    width: 300,
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(15)),
    child: (whattobuild == 'Ingredients')
        ? ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                color: Theme.of(context).primaryColor,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(mealDetails.ingredients[index]),
                ),
              );
            },
            itemCount: mealDetails.ingredients.length,
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      child: Text('#${index + 1}'),
                    ),
                    title: Text(mealDetails.steps[index]),
                  ),
                  Divider()
                ],
              );
            },
            itemCount: mealDetails.steps.length,
          ),
  );
}

Widget buildSectiontitle(BuildContext context, String title) {
  return Container(
      margin: EdgeInsets.all(10),
      height: 30,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ));
}

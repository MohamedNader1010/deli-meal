import 'package:deli_meal/dummy_data.dart';
import 'package:flutter/material.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';
  final Function toggleFavorite;
  final Function _isMealFavorite;
  MealDetailScreen(this.toggleFavorite, this._isMealFavorite);
  Widget buildContainer(Widget widget) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: 150,
        width: 300,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.pink,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: widget);
  }

  Widget buildTextSection(BuildContext context, String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.title,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal =
        DUMMY_MEALS.firstWhere((element) => element.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(selectedMeal.imageUrl),
            ),
            buildTextSection(context, 'Ingredients'),
            buildContainer(
              ListView.builder(
                padding: EdgeInsets.all(5),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    color: Colors.purpleAccent,
                    child: Text('${selectedMeal.ingredients[index]}'),
                  );
                },
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
            SizedBox(height: 10),
            buildTextSection(context, 'Steps'),
            buildContainer(
              ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.purpleAccent,
                          child: Text('# ${index + 1}'),
                        ),
                        title: Text(
                          selectedMeal.steps[index],
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      Divider(
                        endIndent: 20,
                        indent: 20,
                        thickness: 2,
                      ),
                    ],
                  );
                },
                itemCount: selectedMeal.steps.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          toggleFavorite(mealId);
        },
        child: !_isMealFavorite(mealId)
            ? Icon(Icons.star_border)
            : Icon(Icons.star),
      ),
    );
  }
}

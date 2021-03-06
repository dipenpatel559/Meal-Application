import 'package:flutter/material.dart';
import 'package:mealapp/dummy_data.dart';
import '../widgets/category_item.dart';

class CategoryScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text(
        //     'Meal Application',
        //     style: TextStyle(
        //         fontSize: 24,
        //         fontWeight: FontWeight.w300),
        //   ),
        // ),
        body: GridView(
              padding: const EdgeInsets.all(18),
              children: dummyCategory
                  .map((catData) => Card(
                clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                    ),
                    elevation: 10,
                      child: CategoryItem(
                          catData.id, catData.title, catData.color)))
                  .toList(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20),
            ),
          );
  }
}

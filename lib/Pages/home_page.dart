import 'package:flutter/material.dart';
import 'package:flora/models/category.dart';
import 'package:flora/widgets/Drawer.dart';
import 'package:flora/widgets/custom_card.dart';
import 'package:flora/Pages/list_of_items_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Category> categories = [
    Category(name: 'Category 1', imageUrl: 'assets/images/scholar.png'),
    Category(name: 'Category 2', imageUrl: 'assets/images/scholar.png'),
    Category(name: 'Category 3', imageUrl: 'assets/images/scholar.png'),
    Category(name: 'Category 4', imageUrl: 'assets/images/scholar.png'),
    Category(name: 'Category 5', imageUrl: 'assets/images/scholar.png'),
    Category(name: 'Category 6', imageUrl: 'assets/images/scholar.png'),
    Category(name: 'Category 7', imageUrl: 'assets/images/scholar.png'),
    Category(name: 'Category 8', imageUrl: 'assets/images/scholar.png'),
    Category(name: 'Category 9', imageUrl: 'assets/images/scholar.png'),
  ];

  int _calculateCrossAxisCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 1200) {
      return 5;
    } else if (screenWidth > 800) {
      return 4;
    } else if (screenWidth > 600) {
      return 3;
    } else {
      return 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    int crossAxisCount = _calculateCrossAxisCount(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double cellHeight = 200;
    double cellWidth = screenWidth / crossAxisCount;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      drawer: const MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
            childAspectRatio: cellWidth / cellHeight,
          ),
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
            final category = categories[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ItemsList()),
                );
              },
              child: MyCard(
                imageUrl: category.imageUrl,
                text: category.name,
              ),
            );
          },
        ),
      ),
    );
  }
}

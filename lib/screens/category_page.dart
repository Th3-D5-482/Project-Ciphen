import 'package:ciphen/constants/popular.dart';
import 'package:ciphen/database/homedb.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  final int catID;
  final String catName;
  const CategoryPage({
    super.key,
    required this.catID,
    required this.catName,
  });

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late Future<List<Map<String, dynamic>>> funitureFuture;

  @override
  void initState() {
    super.initState();
    funitureFuture = getFurnitures();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: funitureFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          final furnitures = snapshot.data!;
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 28,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Category: ${widget.catName}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: GridView.builder(
                        itemCount: furnitures
                            .where((furniture) =>
                                furniture['catID'] == widget.catID)
                            .toList()
                            .length,
                        scrollDirection: Axis.vertical,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.63,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final furnitureItem = furnitures
                              .where((furniture) =>
                                  furniture['catID'] == widget.catID)
                              .toList()[index];
                          return Card(
                            child: Popular(
                              imageUrl: furnitureItem['imageUrl'],
                              furName: furnitureItem['furName'],
                              price: furnitureItem['price'],
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

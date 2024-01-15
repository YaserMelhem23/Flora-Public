import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flora/widgets/Drawer.dart';
import 'package:flora/Pages/item_details_page.dart';

class ItemsList extends StatefulWidget {
  const ItemsList({Key? key}) : super(key: key);

  @override
  State<ItemsList> createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  final TextEditingController _searchController = TextEditingController();
  String _filter = 'All';
  final DatabaseReference itemsRef =
      FirebaseDatabase.instance.ref().child('Items');

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search items',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white),
          ),
          style: const TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          PopupMenuButton<String>(
            onSelected: (String value) {
              setState(() {
                _filter = value;
              });
            },
            itemBuilder: (BuildContext context) {
              return [
                'All',
                'Category A',
                'Category B',
                'Category C',
                'Category D'
              ].map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      drawer: const MyDrawer(),
      body: StreamBuilder(
        stream: itemsRef.onValue,
        builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          if (snapshot.hasData &&
              !snapshot.hasError &&
              snapshot.data!.snapshot.value != null) {
            List<dynamic> itemList =
                snapshot.data!.snapshot.value as List<dynamic>;
            List<Map<String, dynamic>> items = itemList
                .map((item) => Map<String, dynamic>.from(item))
                .toList();

            return ListView.separated(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ItemDetails(item: item),
                    ));
                  },
                  child: Container(
                    color: item['color'],
                    child: Row(
                      children: [
                        item['image'] != null
                            ? Image.network(
                                item['image'],
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              )
                            : const SizedBox(width: 100, height: 100),
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item['name'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                              Text(item['category'],
                                  style: const TextStyle(fontSize: 14)),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item['price'],
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            Text(item['rating'],
                                style: const TextStyle(fontSize: 14)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  thickness: 2,
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

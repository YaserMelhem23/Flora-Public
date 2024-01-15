import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flora/main.dart';
import 'package:flora/widgets/listTile.dart';
import 'package:flora/Pages/login_page.dart';
import 'package:flora/Pages/register_page.dart';
import 'package:firebase_database/firebase_database.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final Auth _auth = Auth();
  final FirebaseService _firebaseService = FirebaseService();
  UserDetails? userDetails;

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    userDetails = await _firebaseService.getUserFromDatabase();
    if (mounted) {
      setState(() {});
    }
  }

  void _addItemsToDatabase() async {
    final DatabaseReference itemsRef =
        FirebaseDatabase.instance.ref().child("Items");

    List<Map<String, String>> items = [
      {
        'name': 'Item A',
        'category': 'Subcategory A',
        'image': 'assets/images/scholar.png',
        'price': '\$14.99',
        'rating': '4.6 stars',
      },
      {
        'name': 'Item B',
        'category': 'Subcategory B',
        'image': 'assets/images/scholar.png',
        'price': '\$9.99',
        'rating': '4.4 stars',
      },
      {
        'name': 'Item C',
        'category': 'Subcategory C',
        'image': 'assets/images/scholar.png',
        'price': '\$39.99',
        'rating': '4.3 stars',
      },
      {
        'name': 'Item D',
        'category': 'Subcategory D',
        'image': 'assets/images/scholar.png',
        'price': '\$599.99',
        'rating': '3.9 stars',
      },
      {
        'name': 'Item E',
        'category': 'Subcategory A',
        'image': 'assets/images/scholar.png',
        'price': '\$12.99',
        'rating': '4.8 stars',
      },
      {
        'name': 'Item F',
        'category': 'Subcategory C',
        'image': 'assets/images/scholar.png',
        'price': '\$59.99',
        'rating': '4.6 stars',
      },
      {
        'name': 'Item F',
        'category': 'Subcategory C',
        'image': 'assets/images/scholar.png',
        'price': '\$59.99',
        'rating': '4.6 stars',
      },
      {
        'name': 'Item F',
        'category': 'Subcategory C',
        'image': 'assets/images/scholar.png',
        'price': '\$59.99',
        'rating': '4.6 stars',
      },
      {
        'name': 'Item R',
        'category': 'Subcategory C',
        'image': 'assets/images/scholar.png',
        'price': '\$59.99',
        'rating': '4.6 stars',
      },
      {
        'name': 'Item F',
        'category': 'Subcategory C',
        'image': 'assets/images/scholar.png',
        'price': '\$59.99',
        'rating': '4.6 stars',
      },
      {
        'name': 'Item D',
        'category': 'Subcategory C',
        'image': 'assets/images/scholar.png',
        'price': '\$59.99',
        'rating': '4.6 stars',
      },
      {
        'name': 'Item S',
        'category': 'Subcategory C',
        'image': 'assets/images/scholar.png',
        'price': '\$59.99',
        'rating': '4.6 stars',
      },
      {
        'name': 'Item F',
        'category': 'Subcategory C',
        'image': 'assets/images/scholar.png',
        'price': '\$59.99',
        'rating': '4.6 stars',
      },
      {
        'name': 'Item F',
        'category': 'Subcategory C',
        'image': 'assets/images/scholar.png',
        'price': '\$59.99',
        'rating': '4.6 stars',
      },
      {
        'name': 'Item F',
        'category': 'Subcategory C',
        'image': 'assets/images/scholar.png',
        'price': '\$59.99',
        'rating': '4.6 stars',
      },
      {
        'name': 'Item F',
        'category': 'Subcategory C',
        'image': 'assets/images/scholar.png',
        'price': '\$59.99',
        'rating': '4.6 stars',
      },
      {
        'name': 'Item F',
        'category': 'Subcategory C',
        'image': 'assets/images/scholar.png',
        'price': '\$59.99',
        'rating': '4.6 stars',
      },
      {
        'name': 'Item F',
        'category': 'Subcategory C',
        'image': 'assets/images/scholar.png',
        'price': '\$59.99',
        'rating': '4.6 stars',
      },
      {
        'name': 'Item v',
        'category': 'Subcategory C',
        'image': 'assets/images/scholar.png',
        'price': '\$59.99',
        'rating': '4.6 stars',
      },
    ];

    await itemsRef.set(items).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Items added to the database")),
      );
    }).catchError(
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to add items: $error")),
        );
      },
    );
  }

  void _signOut() async {
    await _auth.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(userDetails?.userName ?? "No Name"),
            accountEmail: Text(userDetails?.email ?? "No Email"),
            currentAccountPicture: userDetails?.profilePhoto != null
                ? CircleAvatar(
                    backgroundImage: NetworkImage(userDetails!.profilePhoto),
                  )
                : const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
            otherAccountsPictures: [
              Tooltip(
                message: userDetails?.address ?? "Address not provided",
                child: const Icon(Icons.location_on),
              ),
              Tooltip(
                message:
                    userDetails?.mobileNumber ?? "Mobile number not provided",
                child: const Icon(Icons.phone),
              ),
            ],
          ),
          const MyMenuList(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Sign Out'),
            onTap: _signOut,
          ),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Add Items'),
            onTap: _addItemsToDatabase,
          ),
        ],
      ),
    );
  }
}

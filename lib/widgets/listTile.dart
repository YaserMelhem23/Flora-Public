import 'package:flora/Pages/home_page.dart';
import 'package:flutter/material.dart';

class MyMenuList extends StatefulWidget {
  const MyMenuList({super.key});

  @override
  State<MyMenuList> createState() => _MyMenuListState();
}

class _MyMenuListState extends State<MyMenuList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text("Home"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => HomePage(),
              ),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.man),
          title: const Text("Men"),
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (_) => const Birthdays(),
            //   ),
            // );
          },
        ),
        ListTile(
          leading: const Icon(Icons.woman),
          title: const Text("Woman"),
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (_) => const Gratitude(),
            //   ),
            // );
          },
        ),
        ListTile(
          leading: const Icon(Icons.payment),
          title: const Text("Offers"),
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (_) => const Reminder(),
            //   ),
            // );
          },
        ),
        const Divider(
          thickness: 2,
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text("Settings"),
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (_) => const Settings(),
            //   ),
            // );
          },
        ),
      ],
    );
  }
}

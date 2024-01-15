import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  MyCard({super.key, required this.text, required String imageUrl});
  String? text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.height * 0.1,
      child: Card(
        elevation: 50,
        color: Colors.blueAccent,
        child: Column(
          children: [
            Container(
              // decoration: BoxDecoration(
              //     // borderRadius: BorderRadius.circular(1),
              //     ),
              width: double.infinity,
              color: Colors.indigo,
              child: Image.asset(
                "assets/images/scholar.png",
                height: 128,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 8),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  text!,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

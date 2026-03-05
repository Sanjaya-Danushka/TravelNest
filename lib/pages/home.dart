import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Column(
          children: [
            Image.asset(
              "assets/images/home1.jpg",
              width: MediaQuery.of(context).size.width,
            ),
          ],
        ),
      ),
    );
  }
}

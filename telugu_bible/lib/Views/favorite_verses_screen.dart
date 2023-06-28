import 'package:flutter/material.dart';

class FavoriteVersesScreen extends StatelessWidget {
  const FavoriteVersesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Favorite Verses Screen"),
        elevation: 0,
      ),
    );
  }
}

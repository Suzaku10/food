import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FoodDetailPage extends StatefulWidget {
  final String? name;

  const FoodDetailPage({Key? key, this.name}) : super(key: key);

  @override
  _FoodDetailPageState createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Modular.args.data['id']),
      ),
    );
  }
}

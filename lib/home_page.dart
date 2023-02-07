import 'package:buscador_gif/Services/GifService.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();

    GifService.get().then((value) => print(value));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
